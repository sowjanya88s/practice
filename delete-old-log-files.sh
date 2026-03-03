#!/bin/bash

id=$(id -u)
LOGS_DIR=/home/ec2-user/app-logs
LOGS_FILE="$LOGS_DIR/$(basename "$0").log"
exec >> "$LOGS_FILE" 2>&1
if [ $id -ne 0 ]; then
echo "please run with root user credentials"
exit 1
fi

if [ ! -d $LOGS_DIR ]; then
echo "$source_dir does not exists"
fi


Files=$(find $LOGS_DIR -name "*.log" -type f -mtime +14)
if [ -z "$Files" ]; then
   echo " files older than 14 days does not exists"
   else
    while IFS= read -r line; do
        echo "files to be deleted: $line"
        rm -f $line
        echo "$line deleted"
    done <<< "$Files"
 fi
 

