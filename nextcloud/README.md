# Installation
- first run without config/secrits mounts
- install oidc app

# OIDC setup with keycloak
- create client, configure oidc.config.php
- create protocol mapper for groups
	- 'Group Membership', 'groups'


# Updating
- maintenance mode 
- new image, start container without mounting secrets/configs 
- check settings/admin/overview till "Your version is up to date. "
- check for setup warnings
- restart container with mounted configs/ secrets


# define default widgets for dashboard (to be welcome, files, talk)
```
docker exec --user www-data -it $docker_container php ./occ config:app:set dashboard layout --value='welcome,recommendations,spreed'

```