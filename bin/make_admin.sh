#!/bin/sh

container_id=$(docker ps -qf "name=nextcloud_app")

if [ $1 ] 
then
  username=$1
else
  echo username?
  read username
fi

docker exec -it --user www-data $container_id php ./occ group:adduser admin $username