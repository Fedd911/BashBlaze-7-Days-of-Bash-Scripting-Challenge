#!/bin/bash

FILE=$1
USER=$2
DESTINATION=$3

echo "Transferring file..."
sleep 2

if [[ -z "$DESTINATION" ]]; then

scp -r "$FILE" root@"$USER":~/

else
scp -r "$FILE" root@"$USER":"$DESTINATION"

fi

if [[ $? -eq 0 ]]; then

echo "Transfer complete!!"

else
 echo "ERROR: Issue with the transfer, please complete it manually instead."
fi
