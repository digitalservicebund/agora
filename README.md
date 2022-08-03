<h1>
   <img src="/.github/images/agora_logo.png" width="209" alt="Agora" title="Agora"> 
</h1>

Agora is a platform for collaboration. Users can connect, share files, chat, discuss and share knowledge. It bundles existing [open source projects](#built-with) with [Nextcloud](https://github.com/nextcloud/server) at its core.

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

```Shell
./bin/init_swarm.sh
```

## we use socket proxy for traefik

see this: https://medium.com/@containeroo/traefik-2-0-paranoid-about-mounting-var-run-docker-sock-22da9cb3e78c

3. configure stacks

Most stack require some configuration and secrets. For an initial setup, check the instructions at [/edge](/edge/), [/forum](/forum/), [/keycloak](/keycloak/), [/wiki](/wiki) and [/monitor](/monitor/).
docker stack deploy does not support environment variables, hence for production:

4. deploy stacks

_manually_:

```Shell
$ env ENV=prod HOST=agora-oegd.de docker stack deploy -c edge.yml edge
$ env ENV=prod HOST=agora-oegd.de docker stack deploy -c wiki.yml wiki --with-registry-auth
$ env ENV=prod HOST=agora-oegd.de docker stack deploy -c forum.yml forum --with-registry-auth
$ env ENV=prod HOST=agora-oegd.de docker stack deploy -c nextcloud.yml nextcloud --with-registry-auth
```

_automated_:

```Shell
./bin/deploy.sh edge
```

## Licensing
