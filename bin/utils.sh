#! bin/sh

set -e

_input() {
  printf "\033[0;33m%s\033[0m" "$1"
}

_get_env() {
  CONF_FILE=bin/local.env

  if [ -f "$CONF_FILE" ]; then
    source $CONF_FILE
  else
    _input "What's the environment? (test, staging, prod): "
    read -r env 
    _input "What's your host's domain? (including subdomain): "
    read -r host

    cat > $CONF_FILE << EOF
# local settings
env=$env
host=$host
EOF
  fi
}