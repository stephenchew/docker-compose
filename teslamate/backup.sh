#!/bin/bash

if [ -d "$1" ]; then
  BACKUP_DIR=$1
else
  SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
  BACKUP_DIR=$SCRIPT_DIR
fi

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
now=$(date +"%A" | awk '{print tolower($0)}')
docker compose -f /root/containers/teslamate/docker-compose.yaml exec -T database pg_dump -U teslamate teslamate > ${BACKUP_DIR}/teslamate_db_${now}.bak
rclone copy --max-age 24h ${BACKUP_DIR} --include 'teslamate*.bak' gdrive:Teslamate
