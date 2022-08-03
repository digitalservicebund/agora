# Installing

make a copy of .env (e.g. prod.env) and insert your smtp.

deploy the stack (e.g. for test environment):

```Shell
env ENV=test HOST=test.agora-oegd.de docker stack deploy -c forum.yml forum --with-registry-auth
```

## conenct with keycloak

For connecting with keycloak, a [PlugIn](https://meta.discourse.org/t/openid-connect-authentication-plugin/103632) is installed and needs to be configured in discourse's admin gui.
