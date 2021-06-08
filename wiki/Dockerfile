FROM mediawiki:1.36

# install PluggableAuth Extension
RUN curl https://extdist.wmflabs.org/dist/extensions/PluggableAuth-REL1_36-78cb499.tar.gz --output PluggableAuth-REL1_36-78cb499.tar.gz
RUN tar -xzf PluggableAuth-REL1_36-78cb499.tar.gz -C /var/www/html/extensions
RUN rm PluggableAuth-REL1_36-78cb499.tar.gz

# download OpenIDConnect
RUN curl https://extdist.wmflabs.org/dist/extensions/OpenIDConnect-REL1_36-9703a4e.tar.gz --output OpenIDConnect-REL1_36-9703a4e.tar.gz
RUN tar -xzf OpenIDConnect-REL1_36-9703a4e.tar.gz -C /var/www/html/extensions
RUN rm OpenIDConnect-REL1_36-9703a4e.tar.gz