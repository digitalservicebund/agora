#! bin/sh

set -e

_input() {
  printf "\033[0;33m%s\033[0m" "$1"
}

_get_env() {
  _input "What's the environment? (test, staging, prod): "
  # check if shit already exists
  read -r env 
  _input "What's your host's domain? (including subdomain): "
  read -r host
}