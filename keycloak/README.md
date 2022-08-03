# Keycloak

Comes with an Agora theme and some small extensions:

## Extensions

- `agora-welcome` is an EventListener, that sends Welcome Mails to new Users
- `survey-required-action` adds an RequiredAction for a User Survey

- profile.properties enables fine_grained_auth
- startup_scripts sets logging options (see https://github.com/keycloak/keycloak-containers/tree/master/server#running-custom-scripts-on-startup)

- we are using https://github.com/danielmiessler/SecLists/blob/master/Passwords/xato-net-10-million-passwords-1000000.txt from @danielmiessler!

## Installing

The following files need an updated copy, namespaced with the desired environment:

- [app/.env](app/.env) (e.g. app/test.env)
- [app/keycloak_password.txt](app/keycloak_password.txt) (the first admin user's password)
- [db/.env](db/.env)
- [db/db_password.txt](db/db_password.txt)

deploy the stack (e.g. for test environment):

```Shell
env ENV=test HOST=test.agora-oegd.de docker stack deploy -c keycloak.yml keycloak --with-registry-auth
```
