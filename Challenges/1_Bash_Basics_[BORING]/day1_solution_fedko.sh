#!/usr/bin/env bash

#This is a script in line with day 1 of the BashBlaze challenge.

#Task 2 is to print a simple message.

echo "Linux is love, Linux is life..."

sleep 1

#Task 3 wants me to create variables and assign values to them.

name="Fyodor"

lastName="notDostoevsky"

echo "My first name is $name"
sleep 1
echo "My last name is $lastName"

#Task 4 Take two variables and make them perform a simple task.

number1=35
number2=14
sum=$((number1 + number2))

sleep 2
echo "If we take $number1 and add $number2 to it, we get $sum."

#Task 5 is to utilise atleast 3 built-in variables.

sleep 1
echo "Here is the exit status of the last executed command $?"
sleep 1
echo "By the way, did you know the name of this script is $0"
sleep 1
echo "The ID of the current shell is $$"

#Task 6 use wildcards to list files with a certain extension in the same directoy.

sleep 2

echo "The script will no show you all the files ending in a certain extension within a dir of your choice"

read -p "Enter the directory you would like to check: " directory
read -p "Enter the extension you would like to check for: " extension

find "$directory" -type f -name "*.$extension"