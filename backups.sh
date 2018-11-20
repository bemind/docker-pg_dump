#!/bin/bash

source /pgenv.sh

MYDATE=`date +%Y-%m-%d_%H%M%S`
MYBACKUPDIR=/data
mkdir -p ${MYBACKUPDIR}
cd ${MYBACKUPDIR}

echo "Backup running to $MYBACKUPDIR" >> /var/log/cron.log
echo "Job started at $(date)" >> /var/log/cron.log

echo "Backing up $PGDATABASE"  >> /var/log/cron.log
FILENAME=${MYBACKUPDIR}/${DUMPPREFIX}_${PGDATABASE}_${MYDATE}.dump
pg_dump ${PGDATABASE} > ${FILENAME}
gzip ${FILENAME}

echo $FILENAME >> /var/log/cron.log
echo "Job ended at $(date)" >> /var/log/cron.log
