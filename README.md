# mysql-backup
bash script for daily backup mysql databse. The backup will keep the backup file for 30 days and automatic delete if more than 30 days.

# Backup database schedule
Please add below line in your crontab to automate the daily backup. Feel free to adjust the backup time according to you needs. Default is 01:05AM everydays.  
05 01 * * * /opt/scripts/mysql-backup.sh > /dev/null 2>&1
