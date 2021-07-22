FROM ubuntu:latest as app-builder

ARG CONTACTS_VERSION=v4.0.0

RUN apt-get update && apt-get install -y curl

# add contacts app
RUN curl -fsSL https://github.com/nextcloud/contacts/releases/download/${CONTACTS_VERSION}/contacts.tar.gz --output contacts.tar.gz && \
	tar -xzf contacts.tar.gz && \
	ls 

## bruteforcesettings?!
## external
## oidc_login
## theme_customcss
## group_everyone
## spreed
## welcome




FROM nextcloud:22.0-fpm-alpine

LABEL org.opencontainers.image.source https://github.com/zechmeister/agora
ENV PHP_MEMORY_LIMIT 1024M

# tune php-fpm
ARG MAX_CHILDREN=120
ARG START_SERVERS=12
ARG MIN_SPARE=6
ARG MAX_SPARE=18

RUN sed -i "s/pm.max_children = 5/pm.max_children = ${MAX_CHILDREN}/g" /usr/local/etc/php-fpm.d/www.conf && \
		sed -i "s/pm.start_servers = 2/pm.start_servers = ${START_SERVERS}/g" /usr/local/etc/php-fpm.d/www.conf && \
		sed -i "s/pm.min_spare_servers = 1/pm.min_spare_servers = ${MIN_SPARE}/g" /usr/local/etc/php-fpm.d/www.conf && \
		sed -i "s/pm.max_spare_servers = 3/pm.max_spare_servers = ${MAX_SPARE}/g" /usr/local/etc/php-fpm.d/www.conf

COPY --from=app-builder contacts /var/www/html/custom_apps/contacts

COPY contacts_renaming /var/www/html/custom_apps/contacts_renaming
RUN chmod +x /var/www/html/custom_apps/contacts_renaming/replace.sh 
RUN	/bin/sh /var/www/html/custom_apps/contacts_renaming/replace.sh

RUN ls /var/www/
# execute script