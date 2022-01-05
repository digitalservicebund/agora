#!/bin/sh

# echo make sure to update forum.yml to desired version

# run backup
docker exec -it $(docker ps -f name=forum -q) discourse backup

# backup discourse's backup files 
# check if folder exists first
BACKUP_DIR=../agora_backups/discourse
[ ! -d "$BACKUP_DIR" ] && echo "backup folder does not exist, creating one..." && mkdir $BACKUP_DIR
docker cp $(docker ps -f name=forum -q):/var/www/discourse/public/backups/default/ $BACKUP_DIR