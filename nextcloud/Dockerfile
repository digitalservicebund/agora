FROM nextcloud:21-fpm-alpine

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

