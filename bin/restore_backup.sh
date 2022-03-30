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

          _info "Restore nextcloud_db..."
          docker run --rm --volumes-from $container -v $(pwd)/$today:/backup ubuntu bash -c "cd /var/lib/mysql && tar xvf /backup/nextcloud-db.tar --strip 3"

          _info "Restore nextcloud_data..."
          container=$(docker ps -qf "name=nextcloud_app")
          docker run --rm --volumes-from $container -v $(pwd)/$today:/backup ubuntu bash -c "cd /var/www/html && tar xvf /backup/nextcloud-data.tar --strip 3"
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
