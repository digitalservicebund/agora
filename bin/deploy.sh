#! /bin/sh

source $(dirname "$0")/utils.sh

if [ $1 ]; then
  _get_env

  for var in "$@"; do
    case $var in
      "nextcloud"|"nc")
        container=$(docker ps -qf "name=nextcloud_app")

        # make this reusable?
        if [ $container ]; then
          _input "nextcloud is already running. Remove stack first? (y/n) "
          read -r answer
          if [ "$answer" = "y" ]; then
            docker stack remove nextcloud

            # wait for deletion
            network=$(docker network ls -qf "name=nextcloud")
            echo "waiting for networks to be removed"
            while [ "$network" ]; do
              network=$(docker network ls -qf "name=nextcloud")
            done
          fi
        fi

        env ENV=$env HOST=$host docker stack deploy -c nextcloud.yml nextcloud --with-registry-auth
        ;;
      "edge")
        env ENV=$env docker stack deploy -c edge.yml edge
        ;;
      "keycloak"|"kc")
        env ENV=$env HOST=$host docker stack deploy -c keycloak.yml keycloak --with-registry-auth
        ;;
      "forum")
        env ENV=$env HOST=$host docker stack deploy -c forum.yml forum --with-registry-auth
        ;;
      *)
        _input "choose service from: nextcloud, edge, keycloak, forum ..."
        ;;
    esac
  done
fi
