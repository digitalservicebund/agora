#!/bin/sh

source $(dirname "$0")/utils.sh

excluded_emails="'NULL', 'carolin.bednarz@4germany.org', 'ernesto.rodriguez@4germany.org', 'florian.zechmeister@4germany.org', 'nico.stumpf@4germany.org'"
excluded_orgs="'GA', 'nextcloud_admin', 'Org', 'Admin', 'LVWA', 'MS', 'BMG', 'DigitalService4Germany', 'SMS', 'HU', 'HLPUG', 'HSM', 'Land', 'BB', 'BE', 'BW', 'BY', 'HB', 'HE', 'HH', 'MV', 'NI', 'NW', 'RP', 'SH', 'SL', 'SN', 'ST', 'TH', 'TLKT', 'TLV', 'TMASGFF', 'NLGA', 'LAGeSo', 'Mitte_Test', 'SenGPG', 'LGL', 'Regierung Oberbayern', 'StMGP', 'Projektträger', 'Testzugänge', 'Akademie ÖGW', 'Städtetag'"

_get_orgs() {
  _get_env
  source keycloak/db/$env.env
  container=$(docker ps -qf "name=keycloak_db")

  docker exec $container mysql --user=$MYSQL_USER --password=`cat keycloak/db/db_password.$env.txt` keycloak --default-character-set=utf8 -e "SELECT COUNT(*) FROM KEYCLOAK_GROUP WHERE NAME NOT IN ($excluded_orgs)"
}

_get_users() {
  container=$(docker ps -qf "name=keycloak_db")
  _get_env
  source keycloak/db/$env.env
  docker exec $container mysql --user=$MYSQL_USER --password=`cat keycloak/db/db_password.$env.txt` keycloak --default-character-set=utf8 -e "SELECT COUNT(*) FROM USER_ENTITY WHERE EMAIL NOT IN ($excluded_emails)"
}

_get_emails() {
  container=$(docker ps -qf "name=keycloak_db")
  _get_env
  source keycloak/db/$env.env
  docker exec $container mysql --user=$MYSQL_USER --password=`cat keycloak/db/db_password.$env.txt` keycloak --default-character-set=utf8 -e "SELECT * FROM USER_ENTITY WHERE EMAIL NOT IN ($excluded_emails)"
}

_help() {
  echo "Usage: ./bin/stats.sh [command]"
  echo ""
  echo "Available commands:"
  echo "orgs                  Returns amount of health offices"
  echo "users                 Returns amount of registered users"
  echo "emails                Returns list of emails (best to pipe into csv)"
  echo ""
}

cmd="${1:-}"
case "$cmd" in
  "orgs") _get_orgs ;;
  "users") _get_users ;;
  "emails") _get_emails ;;
  *) _help ;;
esac