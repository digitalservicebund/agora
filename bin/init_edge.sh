#!/bin/sh

set -e

_input() {
  printf "\033[0;33m%s\033[0m" "$1"
}

_get_env() {
  _input "What's the environment? (test, stage, prod): "
  # check if shit already exists
  read -r env 
  _input "What's your host's domain? (including subdomain): "
  read -r host
}

_create_conf_file() {
  file=edge/traefik.$env.toml
  cp edge/traefik.toml $file

  _input "Log to stdout? (y/n) "
  read -r answer
  if [ "$answer" = "n" ]
  then
    sed -i '' 's|#filePath = "/var/log/traefik.log"|filePath = "/var/log/traefik.log"|g' $file
  fi

  _input "Keep access logs? (y/n) "
  read -r answer
  if [ "$answer" = "y" ]
  then
    sed -i '' 's|#filePath = "/var/log/traefik_access.log"|filePath = "/var/log/traefik_access.log"|g' $file
  fi

  _input "Enable debugging? (y/n) "
  read -r answer
  if [ "$answer" = "y" ]
  then
    sed -i '' 's|# level = "DEBUG"|level = "DEBUG"|g' $file
    sed -i '' 's|# \[accessLog.fields\]|\[accessLog.fields\]|g' $file
    sed -i '' 's|# 	defaultMode = "keep"| 	defaultMode = "keep"|g' $file
    sed -i '' 's|# 	\[accessLog.fields.headers\]| 	\[accessLog.fields.headers\]|g' $file
    sed -i '' 's|# 		defaultMode = "keep"| 		defaultMode = "keep"|g' $file
  fi

  # Todo: check if websecure entry point necessary

  _input "Accept forwarded headers? (y/n) "
  read -r answer
  if [ "$answer" = "y" ]
  then
    _input "Proxy's IP? "
    read -r ip
    sed -i '' 's|#\[entryPoints.websecure.forwardedHeaders\]|\[entryPoints.websecure.forwardedHeaders\]|g' $file
    sed -i '' "s|#	trustedIPs = \[\"99.99.99.99\"\]|	trustedIPs = \[\"$ip\"\]|g" $file
  fi

  _input "Email for let's encrypt "
  read -r mail
  sed -i '' "s|email = \"mail@example.com\"|email = \"$mail\"|g" $file
}

_get_env
_create_conf_file

_input "Deploy stack? (y/n) "
read -r answer
if [ "$answer" = "y" ]
then
  env ENV=$env HOST=$host docker stack deploy -c edge.yml edge
fi