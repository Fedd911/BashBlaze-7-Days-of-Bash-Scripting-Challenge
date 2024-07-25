#!/bin/bash
#ATTENTION this script does not take into account the buff/cache memory which can be reclaimed.

#Displaying the help menu
function helpMenu {

echo "---- Monitoring Metrics Script ----"
echo
echo      "1. View System Metrics"
echo      "2. Monitor a Specific Service"
echo      "3. Exit"
echo
echo "------------------------------------"
}

#The function that extracts the system metrics and displays them.
function systemMetrics {
cpuUsage=$(top -b -n 1 | grep Cpu | awk '{print $2}')
memUsage=$(free | grep Mem | awk '{print int($3/$2 * 100)}')
diskUsage=$(df -h | grep sda2 | awk '{print $5}')

echo "---- System Metrics ----"
echo
echo "CPU Usage: $cpuUsage      Mem Usage: $memUsage%   Disk Space: $diskUsage  "
echo
echo "-------------------------"
echo
echo "Press Enter to Exit..."
echo
echo

}

#Monitors a specific service
function serviceMonitor {

        echo "---- Monitor a Specific Service ----"
        echo
        read -p "Enter the name of the service to monitor: " serviceName
        echo
        echo "-------------------------------------"
        echo

        #Checking the service status
        echo "---- $serviceName Status ----"
        echo

        if [[ -n $(pgrep "$serviceName") ]]; then
                echo "$serviceName is running."
                echo
                echo
                echo "Returning to main Menu...."
                sleep 2
                mainLogic
        else
                echo "$serviceName is not running."
                echo "Do you want to start $serviceName? (Y/N):"
                echo
                echo "If you choose "Y", the script will attempt to start $serviceName."
                read decisionInput
        fi

        #Starting the service based on user input
        case "$decisionInput" in
                [Yy])
                        serviceStart
                        ;;

                [Nn])
                        echo "Returning to main Menu...."
                        mainLogic
                        ;;
        esac

}

function serviceStart {

        for (( i = 0 ; i < 3 ; i++)); do
                echo "Attemtping to restart the service: $serviceName."
                systemctl start "$serviceName"
                sleep 3

                if [[ -n $(pgrep "$serviceName") ]]; then

                        echo "The process '$serviceName' has been tarted sucessfully!!!"
                fi
                mainLogic
        done

        echo "Maximum restart attempts reached. Please check the process manually."
        exit 1

}

#Main script logic:
function mainLogic {

helpMenu

read userInput

  case "$userInput" in

        1)
                 read -p "Enter sleep interval (seconds) for the system metrics:" sleepInterval
               (
                 while true; do
                       systemMetrics
                       sleep "$sleepInterval"
               done
               ) &
               # ^^^^ Making the loop a background process in order for the user to be able to stop it with the "Enter" key.

                metrics_pid=$!
                read newInput
                kill $metrics_pid
                echo "Exiting..."
                ;;

        2)
                serviceMonitor
                ;;

        3)
                exit 0
                ;;


        *)

               echo "---"
               echo "Error: Invalid input. Please choose a valid option (1, 2, or 3)."
               echo
               echo
               mainLogic
               ;;

       esac
    }


mainLogic
