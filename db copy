#!/bin/bash
# Run this script only through the jenkins-test server
#
# Ensure no old versions of the db are kept.
ssh postgres@192.168.20.166 \
'if [ -f /backups/jenkins_db_copy.old ]; \
        then rm -f /backups/jenkins_db_copy.old && echo -e "\n.old file found. Removed .old file\n"; \
else echo "No old file found for removal"; \
fi'

# Keep a legacy copy of the database. 
ssh postgres@192.168.20.166 \
'if [ -f /backups/jenkins_db_copy ]; \
        then  mv /backups/jenkins_db_copy /backups/jenkins_db_copy.old && echo -e "Storing legacy copy\n"; \
else echo -e "No copy found. Proceeding with dumping the db.\n"; \
fi'

# Dump the current Jenkins database.
ssh postgres@192.168.20.166  'pg_dump -U jenkins jenkins_db -f /backups/jenkins_db_copy && echo -e "Dumping the DB.\n"'
# Stop all connections to the jenkins_db_copy database


# Check if DB exists - very stupid method, but it works
# this works: ssh root@192.168.20.166 runuser -l postgres -c 'psql -tAc "SELECT * FROM pg_database" | grep "jenkins_db_copy" | wc -l > /tmp/b.out && echo this works'
# this doesn't work for some reason ssh root@192.168.20.166 runuser -l postgres -c 'if [ $(grep "1" /tmp/b.out) == "1" ]; then dropdb jenkins_db_copy; else echo -e "DB not present. Creating\n"; fi'
ssh postgres@192.168.20.166 'dropdb \"jenkins_db_copy\"'
ssh postgres@192.168.20.166 'createdb jenkins_db_copy && echo -e \"Creating the DB.\n\"'


# Restore the database
ssh postgres@192.168.20.166 'psql -U postgres -f /backups/jenkins_db_copy'
