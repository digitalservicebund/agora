#!/bin/sh

source $(dirname "$0")/utils.sh

# echo make sure to update forum.yml to desired version

# backup discourse's backup files 
docker exec -it $(docker ps -f name=forum -q) discourse backup
BACKUP_DIR="../agora_backups/discourse"
[ ! -d "$BACKUP_DIR" ] && mkdir -p $BACKUP_DIR
docker cp $(docker ps -f name=forum -q):/var/www/discourse/public/backups/default/ $BACKUP_DIR

docker stack rm forum
# todo: import & refactor function
./bin/deploy.sh forum

# docker exec -it $(docker ps -f name=forum -q) rake db:migrate

# docker stack rm forum
# ./bin/deploy.sh forum