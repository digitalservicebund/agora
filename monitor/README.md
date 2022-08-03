# Monitoring Stack

Grafana + Loki

- not using promtail, but grafanas docker-driver / plugin (better compatibility with docker swarm)
  https://github.com/grafana/loki/tree/main/clients/cmd/docker-driver

install with

```
docker plugin install  grafana/loki-docker-driver:2.3.0 --alias loki --grant-all-permissions
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

## Nextcloud

- we're using nextcloud's audit app
- enable the app & make sure the logfile is linked to stdout:

```
$ docker exec --user www-data -it <CONTAINER_ID> php ./occ app:enable audit
$ docker exec -it ln -sf /dev/stdout /var/www/html/data/audit.log

```

## deploy stacks

Make a copy of .env (e.g. test.env) and adjust your settings.

deploy the stack (e.g. for test environment):

```Shell
env ENV=test HOST=test.agora-oegd.de docker stack deploy -c monitor.yml monitor --with-registry-auth
```
