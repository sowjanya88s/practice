#!/bin/bash

to_address=$1
subject=$2
message_body=$3
alert_type=$3
ip_address=$4
to_team=$5

message_body=$(echo "$message" | sed -e 's/[]\/$*.^[]/\\&/g')
final_message=$(sed -e "s/to_team/$TO_TEAM/g"   -e "s/message/$final_message_body/g" -e "s/alert_type/$alert_type/g" -e "s/ip_address/$ip_address" template.html)

{
echo "To: $TO_ADDRESS"
echo "Subject: $SUBJECT"
echo "Content-Type: text/html"
echo ""
echo "$FINAL_MESSAGE"
} | msmtp "$TO_ADDRESS"


#Hi DevOps Team,

#There is an issue of DISK_UTILISATION type in the server. Please find the details below.
#Server IP:
#           MESSAGE

# Regards,
# Monitoring Team