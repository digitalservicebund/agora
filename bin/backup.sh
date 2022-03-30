#! /bin/sh

_info() {
  printf "\033[1;33m==> %s\033[0m\n\n" "$1"
}

if [ $1 ]; then
    for var in "$@"; do
    case $var in
      "nextcloud"|"nc")
        container=$(docker ps -qf "name=nextcloud_db")

        if [ $container ]; then
          today=$(date +"%Y%m%d")
          mkdir $today

          _info "Back up nextcloud_db..."
          docker run --rm --volumes-from $container -v $(pwd)/$today:/backup ubuntu tar cvf /backup/nextcloud-db.tar /var/lib/mysql

          _info "Back up nextcloud_data..."
          container=$(docker ps -qf "name=nextcloud_app")
          docker run --rm --volumes-from $container -v $(pwd)/$today:/backup ubuntu tar cvf /backup/nextcloud-data.tar /var/www/html
        else 
          _info "nextcloud is not running. Start the stack first."
        fi
        ;;

      *)
        _info "only nextcloud|nc supported"
        ;;
    esac
  done
fi