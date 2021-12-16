#! /bin/sh

source $(dirname "$0")/utils.sh

if [ $1 ]; then
  _get_env

  case $1 in
    "nextcloud")
      env ENV=$env HOST=$host docker stack deploy -c nextcloud.yml nextcloud --with-registry-auth
      ;;
    *)
      echo "choose service from: nextcloud, ..."
      ;;
  esac
fi