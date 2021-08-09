# Monitoring Stack

Grafana + Loki

- not using promtail, but grafanas docker-driver / plugin (better compatibility with docker swarm)
https://github.com/grafana/loki/tree/main/clients/cmd/docker-driver

install with 

```
docker plugin install  grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
```