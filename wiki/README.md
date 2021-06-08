# Setup OIDC

- select PluggableAuth during installation
- select OpenID Connect during installation 


- add ```wfLoadExtension( 'OpenIDConnect' );``` to LocalSettings.php
- run $ docker exec $$$ php maintenance/update.php



# Todo
- combine RUN Commands