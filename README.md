<h1>
   <img src="/.github/images/agora_logo.png" width="209" alt="Agora" title="Agora"> 
</h1>

Agora is a platform for collaboration. Users can connect, share files, chat, discuss and share knowledge. It bundles existing [open source projects](#built-with) with [Nextcloud](https://github.com/nextcloud/server) at its core. This repository aims to show how these applications can be configured in order to present a coherent user experience.

We need a setup that can reliably serve several hundred users without operating a kubernetes cluster. This is what worked for us:

### Built (mostly) with

- [Nextcloud](https://github.com/nextcloud/server) - file sharing, chat, contacts
- [Keycloak](https://github.com/keycloak/keycloak) - identity and access management
- [Discourse](https://github.com/discourse/discourse) - discussion forum
- [MediaWiki](https://gerrit.wikimedia.org/g/mediawiki/core) - wiki
- [Traefik](https://github.com/traefik/traefik) - reverse proxy, load balancing
- [Grafana](https://github.com/grafana/grafana)/[Loki](https://github.com/grafana/loki) - logging

## Getting Started

### Prerequisites

**docker engine 20.10**
We use [docker swarm](https://docs.docker.com/engine/swarm/) in combination with traefik. This allows for lightweight container orchestration. If you want to use Logging, also [install the loki-docker-driver plugin](/monitor/README.md#install).

### Installing

1. set up swarm and networks

automated:

```Shell
./bin/init_swarm.sh
```

manual:

```Shell
docker swarm init # --advertise-addr <IP/INTERFACE>

# encrypt ingress
docker network rm ingress
docker network create --ingress --driver overlay --opt encrypted ingress
docker network create --driver overlay --scope swarm --opt encrypted --attachable socket-proxy
docker network create --driver overlay --scope swarm --opt encrypted --attachable --subnet 10.20.0.0/16 edge

```

## make ingress encrypted:

```

```

## we use socket proxy for traefik

see this: https://medium.com/@containeroo/traefik-2-0-paranoid-about-mounting-var-run-docker-sock-22da9cb3e78c

## overlay network for traefik and docker socket proxy

```
docker network create --driver overlay --scope swarm --opt encrypted --attachable socket-proxy
```

## network for traefik and public containers

```
docker network create --driver overlay --scope swarm --opt encrypted --attachable --subnet 10.20.0.0/16 edge
```

## deploy stacks

docker stack deploy does not support environment variables, hence for production:

```
$ env ENV=prod HOST=agora-oegd.de docker stack deploy -c edge.yml edge
$ env ENV=prod HOST=agora-oegd.de docker stack deploy -c wiki.yml wiki --with-registry-auth
$ env ENV=prod HOST=agora-oegd.de docker stack deploy -c forum.yml forum --with-registry-auth
$ env ENV=prod HOST=agora-oegd.de docker stack deploy -c nextcloud.yml nextcloud --with-registry-auth
```

## Licensing
