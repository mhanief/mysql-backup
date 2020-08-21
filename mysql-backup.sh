#!/bin/bash

################################################################
##
##   MySQL Database Backup Script
##   Written By: Hanief Harun
##   URL: https://skrinhitam.wordpress.com/
##   Last Update: 3 April, 2020
##
################################################################

#export PATH=/bin:/usr/bin:/usr/local/bin:/opt/bitnami/mysql/bin
export PATH=/bin:/usr/bin:/usr/local/bin
TODAY=`date +"%d%b%Y"`

################################################################
################## Update below values  ########################

DB_BACKUP_PATH='/your/backup/location/goes/here/'
MYSQL_HOST='localhost'
MYSQL_PORT='3306'
MYSQL_USER='your_sql_username'
MYSQL_PASSWORD='your_password'
DATABASE_NAME='your_database_name'
BACKUP_RETAIN_DAYS=30   ## Number of days to keep local backup copy

#################################################################

mkdir -p ${DB_BACKUP_PATH}/${TODAY}
echo "Backup started for database - ${DATABASE_NAME}"


mysqldump -h ${MYSQL_HOST} \
                  -P ${MYSQL_PORT} \
                  -u ${MYSQL_USER} \
                  -p${MYSQL_PASSWORD} \
                  ${DATABASE_NAME} | gzip > ${DB_BACKUP_PATH}/${TODAY}/${DATABASE_NAME}-${TODAY}.sql.gz

if [ $? -eq 0 ]; then
  echo "Database backup successfully completed"
else
  echo "Error found during backup"
fi


##### Remove backups older than {BACKUP_RETAIN_DAYS} days  #####

DBDELDATE=`date +"%d%b%Y" --date="${BACKUP_RETAIN_DAYS} days ago"`

if [ ! -z ${DB_BACKUP_PATH} ]; then
      cd ${DB_BACKUP_PATH}
      if [ ! -z ${DBDELDATE} ] && [ -d ${DBDELDATE} ]; then
            rm -rf ${DBDELDATE}
      fi
fi

### End of script ####
