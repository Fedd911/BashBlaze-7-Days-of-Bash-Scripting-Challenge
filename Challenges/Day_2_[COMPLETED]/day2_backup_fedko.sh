#!/bin/bash

################################################### DESCRIPTION ###################################################

# Your task is to create a bash script that takes a directory path as a command-line argument and performs a backup of the directory. 
# The script should create timestamped backup folders and copy all the files from the specified directory into the backup folder.

# Additionally, the script should implement a rotation mechanism to keep only the last 3 backups. 
# This means that if there are more than 3 backup folders, the oldest backup folders should be removed 
# to ensure only the most recent backups are retained.


################################################### DESCRIPTION ###################################################

################################################### HOW TO USE ###################################################

# Provide the path to the dir you would like to backup as an argument when running the script.

# Example: ./fedko.sh /root/home/

################################################### HOW TO USE ###################################################



inputDir=$1
timestamp=$(date '+%Y-%m-%d_%H:%M:%S')

#Checking to see if the user input is a valid directory.
if [[ ! -d "$inputDir" ]]; then
        echo "$inputDir does not exist."
        sleep 1
        echo "Please, enter a valid directory path"
        exit 1
fi

#Creating a temp dir in which we will store the files that need to be copied.
TEMPDIR=`mktemp -d -p "$TMPDIR"`

if [[ ! "$TEMPDIR" || ! -d "$TEMPDIR" ]]; then
        echo "Could not create temp dir"
        exit 1
fi

#Making a function that makes sure to delete the temp dir.
function cleanup {
        rm -rf "$TEMPDIR"
}

#Registering the function to be called on the EXIT signal (just in case)
 trap cleanup EXIT


#Creating the backup directory
function createBackup {

        #Copying everything from the target dir into the temp dir
        cp -R "$inputDir"/. "$TEMPDIR"

        #Creating a dir with a timestamp
        mkdir "$inputDir"/backup_"$timestamp"

        #Copying everything from the tempdir and putting it into the backup dir
        cp -R "$TEMPDIR"/. "$inputDir"/backup_"$timestamp"

        #Using the script twice in the same DIR causes nested copies.
        #Deleting any nested copies.
        rm -fr "$inputDir"/backup_"$timestamp"/backup_*

}


#Checks to see if there are more than 3 backups present. If true the oldest one is deleted. 
function rotation {
        backupsCount=$(ls -d "$inputDir"/backup_* | wc -l)

        if [[ "$backupsCount" -gt 3 ]]; then
                rm -fr "$inputDir"/"$(ls -rd backup_* | tail -n 1)"
        fi
}



#Calling out the functions

createBackup
rotation