#!/bin/bash
LOGS_DIR=/home/ec2-user/app-logs
LOGS_FILE=$LOGS_DIR/$0.log
id=$(id -u)
source_dir=$1
dest_dir=$2
days=${3:-14}

if [ $id -ne 0 ]; then
echo "pls run the script with root user privileges"
fi

usage() {
    echo "pls pass the arguments: <source-dir> <dest-dir> <days>"
}

log() {
    echo "$(date "+%Y-%m-%d %H:%M:%S") | $1 "
}

if [ $# -lt 2 ]; then
    usage
    exit 1
fi

log "source directory: $source_dir"
log "destination directory: $dest_dir"
log "no.of days: $days"

if [ ! -d $source_dir ]; then
    echo "source directory $source_dir does not exists"
fi

if [ ! -d $dest_dir ]; then
    echo "destination directory $dest_dir does not exists"
fi

files_to_delete=$(find $source_dir -name "*.log" -type f -msize +14)
if [ -z $files_to_delete ]; then
    echo "there are no files to archieve"
else
    while IFS= read -r line ; do
        echo "files to archieve: $line"
        timestamp=$(date +%F-%H-%M-%S)
        Archive_name=$dest_dir/$timestamp.tar.gz
        tar -xzvf $Archive_name $(find $source_dir -name "*.log" -type f -msize +14)
    done <<< $files_to_delete
fi

if [ ! -f $Archive_name ]; then
    log "archival of file...failed"
else
    while IFS= read -r line ; do
        echo "files to delete: $line"
        rm -f $line
        echo "$line deleted"
    done <<< $files_to_delete
fi



