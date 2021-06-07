# Set up swarm

## make ingress encrypted:

```
docker network rm ingress
docker network create --ingress --driver overlay --opt encrypted ingress 
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
```
docker stack deploy -c socket-proxy.yml socket-proxy
docker stack deploy -c keycloak.yml keycloak …

```
