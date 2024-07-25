#!/bin/bash

COMMAND=$1
USER=$2

if [[ -z "$COMMAND" ]]; then
echo "***********************"
echo "    USER MANUAL      "
echo "***********************"
echo "Desrition: Executes a"
echo "command on a remote VM."
echo "***********************"
echo "The script expects 2 arguments:"
echo "1 - The command which needs to be executed"
echo "2 - The VM on which it needs to be executed"
echo
echo "Example: ./remote_execution [COMMAND] [VM_NAME]"
echo "***********************"
exit 0
fi



echo "Executing the command..."
sleep 2
ssh "$USER" "$COMMAND"

if [[ $? -eq 0 ]]; then
 echo "Command executed sucessfully."
 else
 echo "Error: command was not executed properly."
 echo "Apply it manually in order to debug further."
fi
