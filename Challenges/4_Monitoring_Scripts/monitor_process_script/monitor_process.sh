#!/bin/bash

input=$1


#Checks if the process is running
function statusCheck {

                if [[ -n $(pgrep "$input") ]]; then
                echo "The process: '$input' is currently running."
                exit 0
        else
                echo "The process: '$input' is currently not running"
                processRestart

        fi
}

#Restarts the process. This function is called within the "statusCheck" function.
function processRestart {

        for (( i = 0 ; i < 3 ; i++)); do


                echo "Attemtping to restart the service: $input."
                systemctl start "$input"
                sleep 3

                if [[ -n $(pgrep "$input") ]]; then

                        echo "The process '$input' has been restarted sucessfully!!!"
                        exit 0
                fi
        done


        echo "Maximum restart attempts reached. Please check the process manually."
        exit 1
}

statusCheck
