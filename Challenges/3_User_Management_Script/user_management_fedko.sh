#!/bin/bash

input=$1

function helpManual {

        echo "Usage: ${0} [OPTIONS]"
        echo "Options:"
        echo "  -c, --create    Create a new user account."
        echo "  -d, --delete    Delete an existing user account."
        echo "  -r, --reset     Reset password for an existing user account."
        echo "  -l, --list      List all user accounts on the system."
        echo "  -h, --help      Display this help and exit."
}

function createUser {

        read -p "Enter the new username: " userName

        #CHECK IF USERNAME IS AVAILABLE BEFORE CREATION#
        getent passwd "$userName" > /dev/null
        if [[ $? -eq 0 ]]; then
                echo "Error: The user '$userName' already exists ya bastard!!!!"
                echo "Enter a valid username instead."
                exit 1
        fi

        read -p "Enter the password for $userName:" userPassword
        useradd "$userName"
        echo "$userName:$userPassword" | chpasswd

        #CHECK IF THE USER HAS BEEN CREATED
        if [[ $? -eq 0 ]]; then
                echo "User account '$userName' created sucessfully."
        fi
}

function deleteUser {

        read -p "Enter the username you want to delete: " userName

        #CHECK IF THE USER EXISTS
        getent passwd "$userName" > /dev/null

        if [[ $? -eq 0 ]]; then
                 userdel "$userName"
                if [[ $? -eq 0 ]]; then
                        echo "User account '$userName' deleted successfully."
                        exit 1
                fi
        else
             echo "Error: The user '$userName' does not exist ya bastard!!!!!"
             echo "Enter an existing user instead"
             exit 1
      fi
}

function changePassword {

        read -p "Enter the username for the password reset: " userName

        #CHECK IF THE USERNAME IS VALID
        getent passwd "$userName" > /dev/null
        if [[ $? -eq 0 ]]; then

        read -p "Enter the new password for '$userName': " newPass
        echo "$userName:$newPass" | chpasswd

                if [[ $? -eq 0 ]]; then
                        echo "Password for user "$userName" reset sucessfully"
                        exit 1
                fi
        else
          echo "Error: The user '$userName' does not exist ya bastard!!!!"
          echo "Enter a valid username instead."
          exit 1
        fi
}

function listUsers {

        echo "User accounts on the system:"
        awk -F: '{printf "- %s (UID: %s)\n", $1, $3}' /etc/passwd
}


### SCRIPT LOGIC ######

if [[ -z "$input" || "$input" == "-h" || "$input" == "--help" ]]; then

        helpManual

fi


if [[ "$input" == "-c" || "$input" == "--create" ]]; then

        createUser

elif [[ "$input" == "-d" || "$input" == "--delete" ]]; then

        deleteUser

elif [[ "$input" == "-r" || "$input" == "--reset" ]]; then

        changePassword

elif [[ "$input" == "-l" || "$input" == "--llist" ]]; then

        listUsers

else
        echo
        echo "Error: Invalid input '$input'."
        echo
        helpManual
fi

exit 1
