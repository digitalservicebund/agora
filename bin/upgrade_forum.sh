#!/bin/sh

# echo make sure to update forum.yml to desired version

# run backup
docker exec -it $(docker ps -f name=forum -q) discourse backup

# backup discourse's backup files 
docker cp $(docker ps -f name=forum -q):/var/www/discourse/public/backups/default/ ../agora_backups/discourse