#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKUP_DIR="$DIR/backups"
DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"`

mkdir -p $BACKUP_DIR
cd $DIR/data

tar -zcf $BACKUP_DIR/world-$DATE.tar.gz world/

find $BACKUP_DIR -mtime +3 -exec rm -rf {} \;
