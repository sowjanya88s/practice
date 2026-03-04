#!/bin/bash
LOGS_DIR="/opt/apps-dir"
LOGS_FILE="$LOGS_DIR/$0.sh"
message=""

log() {
    echo  -e "$(date "+%Y-%m-%d %H:%M:%S") |  $1"
}

Disk_usage=$(df -Th | grep -v Filesystem)

while IFS= read -r line; do
cpu_utilization=$(echo $line | awk  '{print $6}' | cut -d '%' -f1)
path=$(echo $line | awk  '{print $7}')
usage_Threshold=3
    if [ "$cpu_utilization" -gt "$usage_Threshold" ]; then
        message+="high disk usage on $path : $cpu_utilization% \n"
    fi
done <<< "$Disk_usage"