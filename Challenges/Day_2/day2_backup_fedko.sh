#!/bin/bash

################################################### DESCRIPTION ###################################################

#The script takes as input the path of the dir.
#It then creates a folder in that directory and copies all the files into the newly created dir.
#After that the script checks if there are more than 3 backup files.
#Should there be more than 3 backup dirs, the oldest one gets deleted.

################################################### DESCRIPTION ###################################################



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
        cp -R "$TEMPDIR"/. backup_"$timestamp"

        #Using the script twice in the same DIR causes nested copies.
        #Deleting any nested copies.
        rm -fr "$inputDir"/backup_"$timestamp"/backup_*

}


#Checks to see if there are more than 3 backups present. If true the oldest one is deleted. 
function rotation {
        backupsCount=$(ls -d backup_* | wc -l)

        if [[ "$backupsCount" -gt 3 ]]; then
                rm -fr "$inputDir"/"$(ls -rd backup_* | tail -n 1)"
        fi
}



#Calling out the functions

createBackup
rotation
