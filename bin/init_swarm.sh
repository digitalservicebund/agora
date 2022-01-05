#!/bin/sh

source $(dirname "$0")/utils.sh

_input "Address to advertise? (eth1/ leave empty if none) "
read -r addr
docker swarm init $([ ! -z "$addr" ] && echo "--advertise-addr $addr")

echo "Encrypting ingress network"
echo "y" | docker network rm ingress
# wait for network to be removed
network=$(docker network ls -qf "name=ingress")
while [ "$network" ]; do
  network=$(docker network ls -qf "name=ingress")
done
docker network create --ingress --driver overlay --opt encrypted ingress

_input "Use socket-proxy? (y/n) "
read -r socket
if [ "$socket" = "y" ]; then
    docker network create --driver overlay --scope swarm --opt encrypted --attachable socket-proxy
fi

docker network create --driver overlay --scope swarm --opt encrypted --attachable --subnet 10.20.0.0/16 edge

_info "Swarm is created! Go ahead and deploy all the stacks!"