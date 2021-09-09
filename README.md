# Agora Stack

consisting of 

# Set up swarm

```
$ docker swarm init --advertise-addr <mangers' IP>

```

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

docker stack deploy does not support environment variables, hence for production:

```
$ env ENV=prod HOST=agora-oegd.de docker stack deploy -c edge.yml edge 
$ env ENV=prod HOST=agora-oegd.de docker stack deploy -c wiki.yml wiki --with-registry-auth
$ env ENV=prod HOST=agora-oegd.de docker stack deploy -c forum.yml forum --with-registry-auth
$ env ENV=prod HOST=agora-oegd.de docker stack deploy -c nextcloud.yml nextcloud --with-registry-auth
```
