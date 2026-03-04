#!/bin/bash
LOGS_DIR="/opt/apps-dir"
LOGS_FILE="$LOGS_DIR/$0.sh"
message=""

log() {
    echo "$(date +%Y-%m-%d %H:%M:%S) |  $1"
}

Disk_usage=$(df -Th | grep -v Filesystem)

while IFS= read -r line; do
cpu_utilization=$(echo line | awk -F ' ' '{print $6}' | cut -d '%' -f1)
path=$(echo line | awk -F ' ' '{print $7}')
usage_Threshold=3
    if [ "$cpu_utilization" -gt "$Usage_Threshold" ]; then
        message+=echo -e "high disk usage on $path on disk $cpu_utilization \n"
    fi
done <<< $Disk_usage