# general setup
- use own dockerfile
- include apps we're using to not depend on the nextcloud app store for updates/installing apps 


# Installation
- first run without config/secrits mounts
- install oidc app

# OIDC setup with keycloak
- create client, configure oidc.config.php
- create protocol mapper for groups
	- 'Group Membership', 'groups'


# Updating
- maintenance mode 
- just pull new image?

# Update custom_apps
- got to remove the custom_apps volume (since it's part of the bigger volume and new app versions are part of image)
```
$ docker stack rm nextcloud
$ docker volume rm nextcloud_nextcloud-apps
```
… then redeploy the stack 


# Configs 

## define default widgets for dashboard (to be welcome, files, talk)
```
$ docker exec --user www-data -it $docker_container php ./occ config:app:set dashboard layout --value='welcome,recommendations,spreed'

```

## remove 'Umfangreiche Arbeitsbereiche'
```
$ docker exec --user www-data -it $docker_container php ./occ config:app:set text workspace_available --value=0

```