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

# add Widgets extension
RUN curl https://extdist.wmflabs.org/dist/extensions/Widgets-REL1_36-bba5b5e.tar.gz --output Widgets-REL1_36-bba5b5e.tar.gz && \
	tar -xzf Widgets-REL1_36-bba5b5e.tar.gz -C /var/www/html/extensions && \
	chown -R www-data:www-data /var/www/html/extensions/Widgets && \
	rm Widgets-REL1_36-bba5b5e.tar.gz


# php config
COPY agora.ini /usr/local/etc/php/conf.d/agora.ini