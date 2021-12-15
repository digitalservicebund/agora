FROM ubuntu:latest as app-builder

# load custom apps
RUN apt-get update && apt-get install -y curl


ARG WELCOME_VERSION=1.0.1-2-nightly
ARG CONTACTS_VERSION=4.0.6
ARG EXTERNAL_VERSION=3.9.0
ARG SPREED_VERSION=13.0.1
ARG CUSTOMCSS_VERSION=1.10.0
ARG OIDC_VERSION=2.0.4
ARG EVERYONE_VERSION=0.1.8
ARG DECK_VERSION=1.6.0
ARG ANTIVIRUS_VERSION=3.2.2
ARG RICHDOCUMENTS_VERSION=5.0.0


# add welcome app
RUN curl -fsSL https://github.com/eneiluj/welcome/releases/download/v${WELCOME_VERSION}/welcome-${WELCOME_VERSION}.tar.gz --output var/welcome.tar.gz && \
	mkdir var/apps && \
	tar -xzf var/welcome.tar.gz -C var/apps 

# add contacts app
RUN curl -fsSL https://github.com/nextcloud/contacts/archive/refs/tags/v${CONTACTS_VERSION}.tar.gz --output var/contacts.tar.gz && \
	tar -xzf var/contacts.tar.gz -C var/apps && \
	mv var/apps/contacts-${CONTACTS_VERSION} var/apps/contacts

# add external app
RUN curl -fsSL https://github.com/nextcloud/external/releases/download/v${EXTERNAL_VERSION}/external-${EXTERNAL_VERSION}.tar.gz --output var/external.tar.gz && \
	tar -xzf var/external.tar.gz -C var/apps 

# add spreed/talk app
RUN curl -fsSL https://github.com/nextcloud/spreed/archive/refs/tags/v${SPREED_VERSION}.tar.gz --output var/spreed.tar.gz && \
	tar -xzf var/spreed.tar.gz -C var/apps && \
	mv var/apps/spreed-${SPREED_VERSION} var/apps/spreed

# add custom_css app
RUN curl -fsSL https://github.com/juliushaertl/theming_customcss/releases/download/v${CUSTOMCSS_VERSION}/theming_customcss.tar.gz --output var/theming_customcss.tar.gz && \
	tar -xzf var/theming_customcss.tar.gz -C var/apps 

# add oidc_login app
RUN curl -fsSL https://github.com/pulsejet/nextcloud-oidc-login/releases/download/v${OIDC_VERSION}/oidc_login.tar.gz --output var/oidc_login.tar.gz && \
	tar -xzf var/oidc_login.tar.gz -C var/apps 

# add group_everyone app
RUN curl -fsSL https://github.com/icewind1991/group_everyone/releases/download/v${EVERYONE_VERSION}/group_everyone.tar.gz --output var/group_everyone.tar.gz && \
	tar -xzf var/group_everyone.tar.gz -C var/apps 

# add deck app
RUN curl -fsSL https://github.com/nextcloud/deck/releases/download/v${DECK_VERSION}/deck.tar.gz --output var/deck.tar.gz && \
	tar -xzf var/deck.tar.gz -C var/apps 

# add antivirus app
RUN curl -fsSL https://github.com/nextcloud/files_antivirus/releases/download/v${ANTIVIRUS_VERSION}/files_antivirus.tar.gz --output var/files_antivirus.tar.gz && \
	tar -xzf var/files_antivirus.tar.gz -C var/apps 

# add richdocuments app
RUN curl -fsSL https://github.com/nextcloud/richdocuments/releases/download/v${RICHDOCUMENTS_VERSION}/richdocuments.tar.gz --output var/richdocuments.tar.gz && \
	tar -xzf var/richdocuments.tar.gz -C var/apps 


# run script to replace some strings within contacts app
COPY contacts_renaming /var/contacts_renaming
RUN chmod +x /var/contacts_renaming/replace.sh && \
	/bin/sh /var/contacts_renaming/replace.sh /var/apps

FROM nextcloud:23.0-fpm-alpine

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
RUN chown -R www-data /var/www/html/custom_apps
