# Installing

run script for configuration:

```Shell
./bin/init_edge.sh
```

alternatively, make a copy of traefik.toml (e.g. traefik.test.toml) and manually adjust the settings.

deploy the stack (e.g. for test environment):

```Shell
env ENV=test HOST=test.agora-oegd.de docker stack deploy -c edge.yml edge
```
