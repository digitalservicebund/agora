FROM mediawiki:1.36
LABEL org.opencontainers.image.source https://github.com/zechmeister/agora

# add PluggableAuth extension
RUN curl https://extdist.wmflabs.org/dist/extensions/PluggableAuth-REL1_36-78cb499.tar.gz --output PluggableAuth-REL1_36-78cb499.tar.gz && \
	tar -xzf PluggableAuth-REL1_36-78cb499.tar.gz -C /var/www/html/extensions && \
	rm PluggableAuth-REL1_36-78cb499.tar.gz

# add OpenIDConnect extension
RUN curl https://extdist.wmflabs.org/dist/extensions/OpenIDConnect-REL1_36-9703a4e.tar.gz --output OpenIDConnect-REL1_36-9703a4e.tar.gz && \
	tar -xzf OpenIDConnect-REL1_36-9703a4e.tar.gz -C /var/www/html/extensions && \
	rm OpenIDConnect-REL1_36-9703a4e.tar.gz

# add Youtube extension
RUN curl https://extdist.wmflabs.org/dist/extensions/YouTube-REL1_36-c352d8c.tar.gz --output YouTube-REL1_36-c352d8c.tar.gz && \
	tar -xzf YouTube-REL1_36-c352d8c.tar.gz -C /var/www/html/extensions && \
	rm YouTube-REL1_36-c352d8c.tar.gz


# php config
COPY agora.ini /usr/local/etc/php/conf.d/agora.ini