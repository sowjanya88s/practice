#!/bin/bash

id=$(id -u)
source_dir=/app-dir

if [ $id -ne 0 ]; then
echo "please run with root user credentials"
exit 1
fi

if [ ! -d $source_dir ] ; then
echo "$source_dir does not exists"
else
Files=$(find . -name "*.log" -type f -mtime +14)
echo "files to be deleted: $Files"
fi

