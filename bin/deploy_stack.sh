#! /bin/sh

source $(dirname "$0")/utils.sh

if [ $1 ]; then
  _get_env

  case $1 in
    "nextcloud"|"nc")
      env ENV=$env HOST=$host docker stack deploy -c nextcloud.yml nextcloud --with-registry-auth
      ;;
    "edge")
      env ENV=$env docker stack deploy -c edge.yml edge
      ;;
    "keycloak"|"kc")
      env ENV=$env HOST=$host docker stack deploy -c keycloak.yml keycloak --with-registry-auth
      ;;
    *)
      echo "choose service from: nextcloud, edge, keycloak ..."
      ;;
  esac
fi