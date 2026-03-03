#!/bin/bash
LOGS_DIR=/home/ec2-user/app-logs
LOGS_FILE=$LOGS_DIR/archieve-log-files.log
id=$(id -u)
source_dir=$1
dest_dir=$2
days=${3:-14}

if [ $id -ne 0 ]; then
echo "pls run the script with root user privileges"
fi

usage() {
    echo "pls pass the arguments: <source-dir> <dest-dir> <days>" | tee -a $LOGS_FILE
    exit 1
}


log() {
    echo "$(date "+%Y-%m-%d %H:%M:%S") | $1 "
}

if [ $# -lt 2 ]; then
    usage
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

files=$(find "$source_dir" -name "*.log" -type f -mtime +$days)
if [ -z "$files" ]; then
    echo "there are no files to archieve"
else
    echo "files to archieve: $files"
    timestamp=$(date +%F-%H-%M-%S)
    Archive_name="$dest_dir/app-logs-$timestamp.tar.gz"
    tar -zcvf $Archive_name $(find $source_dir -name "*.log" -type f -mtime +$days)
    


if [ ! -f "$Archive_name" ]; then
    log "archival of file...failed"
else
    while IFS= read -r line ; do
        echo "files to delete: $line"
        rm -f $line
        echo "$line deleted"
    done <<< $files
fi

fi



