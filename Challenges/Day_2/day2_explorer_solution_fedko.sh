#!/bin/bash

echo "Welcome stranger. This is my take at an Interactive File and Directory Explorer!"
echo

sleep 3

#Creating a while loop, which will be exited if the user enters an empty string
while true; do
        echo Files and Directories in the Currnet Path:
        ls -lh
        echo
        echo
        sleep 4




#Counts the characters in the input of the user
        read -p "Enter a line of text (Press Enter without text to exit):" input

        if [[ -z "$input" ]]; then
                break
        else
                count=$(echo -n "$input" | tr -d ' ' | wc -c)
                echo "Character Count: $count"
                echo
                sleep 3
        fi
done
