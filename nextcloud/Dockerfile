FROM ubuntu:latest as app-builder

# load custom apps
RUN apt-get update && apt-get install -y curl

ARG CONTACTS_VERSION=v4.0.0
## bruteforcesettings?!
## external
## oidc_login
## theme_customcss
## group_everyone
## spreed
## welcome

# add contacts app
RUN curl -fsSL https://github.com/nextcloud/contacts/releases/download/${CONTACTS_VERSION}/contacts.tar.gz --output var/contacts.tar.gz && \
		mkdir var/apps && \
		tar -xzf var/contacts.tar.gz -C var/apps 

# run script to replace some strings within contacts app
COPY contacts_renaming /var/contacts_renaming
RUN chmod +x /var/contacts_renaming/replace.sh && \
		/bin/sh /var/contacts_renaming/replace.sh /var/apps


FROM nextcloud:22.1-fpm-alpine

LABEL org.opencontainers.image.source https://github.com/zechmeister/agora
ENV PHP_MEMORY_LIMIT 1024M

# forward audit logs to docker log collector
RUN mkdir /var/www/html/data/ && \
		touch /var/www/html/data/audit.log && \ 
		ln -sf /dev/stdout /var/www/html/data/audit.log

# tune php-fpm
ARG MAX_CHILDREN=120
ARG START_SERVERS=12
ARG MIN_SPARE=6
ARG MAX_SPARE=18

RUN sed -i "s/pm.max_children = 5/pm.max_children = ${MAX_CHILDREN}/g" /usr/local/etc/php-fpm.d/www.conf && \
		sed -i "s/pm.start_servers = 2/pm.start_servers = ${START_SERVERS}/g" /usr/local/etc/php-fpm.d/www.conf && \
		sed -i "s/pm.min_spare_servers = 1/pm.min_spare_servers = ${MIN_SPARE}/g" /usr/local/etc/php-fpm.d/www.conf && \
		sed -i "s/pm.max_spare_servers = 3/pm.max_spare_servers = ${MAX_SPARE}/g" /usr/local/etc/php-fpm.d/www.conf

# copy custom apps 
COPY --from=app-builder /var/apps/ /var/www/html/custom_apps
