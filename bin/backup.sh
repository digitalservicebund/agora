#! /bin/sh

set -e

source $(dirname "$0")/utils.sh

_info() {
  printf "\033[1;33m==> %s\033[0m\n\n" "$1"
}

_backup_nextcloud() {
  if [ -z $(docker ps -qf "name=nextcloud_db") ]; then 
    echo ERROR: nextcloud is not running. Start the stack first.
    exit 1
  fi

  _get_env
  source nextcloud/db/$env.env

  nextcloud_app=$(docker ps -qf "name=nextcloud_app")
  nextcloud_db=$(docker ps -qf "name=nextcloud_db")

  _input "backup directory: "
  read -r directory
  time=$(date +"%Y%m%d_%H%M")
  mkdir $directory/$time

  _info "Switch on maintenance mode..."
  docker exec -it --user www-data $nextcloud_app php ./occ maintenance:mode --on

  _info "Evaluate current state..."
  user_dirs=$(docker exec -it --user www-data $nextcloud_app ls data/ | wc -l | tr -dc '0-9')

  n_users=$(docker exec $nextcloud_db mysql --user=$MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE --default-character-set=utf8 -e "SELECT COUNT(*) FROM oc_accounts" | tr -dc '0-9')
  n_shares=$(docker exec $nextcloud_db mysql --user=$MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE --default-character-set=utf8 -e "SELECT COUNT(*) FROM oc_share" | tr -dc '0-9')

  _info "$user_dirs user dirs, $n_users user accounts, $n_shares shares"

  _info "Back up nextcloud_data..."
  docker run --rm --volumes-from $nextcloud_app -v $directory/$time:/backup ubuntu tar cvf /backup/nextcloud_data.tar /var/www/html

  _info "Back up nextcloud_db..."
  docker exec $nextcloud_db mysqldump --user=$MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE > $directory/$time/nextcloud_db.sql
}

_help() {
  echo "Usage: ./bin/backup.sh [stack]"
  echo "Saves the files and db of running nextcloud instance into current dir."
  echo ""
  echo "Available stacks:"
  echo "nextcloud|nc          Creates nextcloud backup"
  echo ""
}

cmd="${1:-}"
case "$cmd" in
  "nextcloud"|"nc") _backup_nextcloud ;;
  *) _help ;;
esac