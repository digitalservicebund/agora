# Monitoring Stack

Grafana + Loki

- not using promtail, but grafanas docker-driver / plugin (better compatibility with docker swarm)
https://github.com/grafana/loki/tree/main/clients/cmd/docker-driver

install with 

```
docker plugin install  grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
```

- set docker daemon to use loki as default logger
https://grafana.com/docs/loki/latest/clients/docker-driver/configuration/#change-the-default-logging-driver

in 'etc/docker/daemon.json':
```
{
        "log-driver": "loki",
        "log-opts": {
                "loki-url": "http://127.0.0.1:3100/loki/api/v1/push",
                "loki-retries": "5",
                "loki-batch-size": "100"
        }       
}
```

- on LogQL https://grafana.com/docs/loki/latest/logql/



