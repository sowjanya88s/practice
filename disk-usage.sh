#!/bin/bash
LOGS_DIR="/opt/apps-dir"
LOGS_FILE="$LOGS_DIR/$0.sh"
message=""
private_ip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

log() {
    echo  -e "$(date "+%Y-%m-%d %H:%M:%S") |  $1"
}

Disk_usage=$(df -Th | grep -v Filesystem)

while IFS= read -r line; do
cpu_utilization=$(echo $line | awk  '{print $6}' | cut -d '%' -f1)
path=$(echo $line | awk  '{print $7}')
usage_Threshold=3
    if [ "$cpu_utilization" -gt "$usage_Threshold" ]; then
        message+="high disk usage on $path : $cpu_utilization% <br>"
    fi
    
done <<< "$Disk_usage"
log "$message"

sh mail.sh "jsowjanya543@gmail.com" "High Disk Usage Alert on $private_ip" "$message" "HIGH_DISK_USAGE" "$private_ip" "DevOps Team"

