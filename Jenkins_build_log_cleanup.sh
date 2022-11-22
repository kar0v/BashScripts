#!/bin/bash
# V1.0 23.07.2021
# This script will purge old logs from the jenkins build directories. 

# present the date as yyyymmdd format 
THREE_MONTHS_AGO=$(date +%Y%m%d --date='-3 month')

# Find all the build log files and present the output as "location yyymmdd" 
# for example: /var/lib/jenkins/jobs/SmokeTest_ProdClients_Nettime/builds/256/log 20210618
sudo find /var/lib/jenkins/jobs/*/builds/ -name log -type f -exec ls -lrt --block-size=M --full-time {} \; | awk '{printf("%s%s ",$9,$10); system("date -d "$6" +%Y%m%d")}' > /tmp/delete.me

# check which logs are older than 3 months
while read line; 
do 
    c1=$(echo "$line" | awk '{print $1}' ); # file location
    c2=$(echo "$line" | awk '{print $2}' ); # file timestamp

    if [[ $c2 -lt $THREE_MONTHS_AGO ]]
        then echo "File $c1 with date $c2 can be removed"
        # purge old files
        # sudo rm -f $c1
    fi
done < /tmp/delete.me

# remove temporary file
rm -f /tmp/delete.me

