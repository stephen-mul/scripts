#!/bin/bash

# Directories to backup
SOURCE_DIRS="/home/stephen/local_workdir/"

# Remote backup destination
REMOTE_USER="stephen"
REMOTE_HOST="raspberrypi"
REMOTE_DIR="/mnt/ssd/backup"

# Rsync options
RSYNC_OPTS="-avz --delete --mkpath"

# Perform backup
for DIR in $SOURCE_DIRS; do
    rsync $RSYNC_OPTS $DIR ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}
done

echo "Backup completed successfully!"

