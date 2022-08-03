# Nextcloud

The nextcloud app store is disabled. Apps we're using are included in the Docker Image.

# Installation

The following files need an updated copy, namespaced with the desired environment:

- [app/.env](app/.env) (e.g. app/test.env)
- [app/agora.config.php](app/agora.config.php)
- [app/oidc.config.php](app/oidc.config.php)
- [db/.env](db/.env)
- [collabora/.env](collabora/.env)

- first run without config/secrits mounts
- set proxy IP in config if nextcloud is behind a proxy
- install oidc app

## OIDC setup with keycloak

- create client, configure oidc.config.php
- create protocol mapper for groups
  - 'Group Membership', 'groups'

# Apps

## install new app

_not possible without downtime right now_

- add to Dockerfile
- reset custom_apps:

```
$ docker volume rm nextcloud_nextcloud-apps
```

- enable new app:

```
$ docker exec --user www-data -it <NC_APP_CONTAINER> php ./occ app:enable <NEW_APP>

```

- limit app to user_groups (generally):

```
# enable app first in order to populate configs:
$ docker exec --user www-data -it <NC_APP_CONTAINER> php ./occ app:enable <NEW_APP>
$ docker exec --user www-data -it <NC_APP_CONTAINER> php ./occ config:app:set <NEW_APP> enabled --value="[\"<GROUP_1>\",\"<GROUP_2>\"]"

```

- settings for Deck-Testphase app:

```
$ docker exec --user www-data -it <NC_APP_CONTAINER> php ./occ config:app:set deck enabled --value="[\"\/Organisation\/DigitalService4Germany\",\"\/GA\/Nordrhein-Westfalen\/Herford\",\"\/GA\/Thueringen\/Kyffhäuserkreis\",\"\/GA\/Baden-Wuerttemberg\/Neckar-Odenwald-Kreis\",\"\/GA\/Berlin\/Steglitz-Zehlendorf\"]"
```

## Update custom_apps

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

## contacts renaming

- script that overwrites some strings in contacts app ([original version](https://github.com/nextcloud/contacts/blob/master/l10n/de.js))
