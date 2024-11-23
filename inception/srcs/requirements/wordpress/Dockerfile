# Base image
FROM alpine:3.19

# PHP version argument
ARG PHP_VERSION=82

# Install PHP, extensions, and necessary packages
RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-redis \
 php${PHP_VERSION}-phar \
    ca-certificates \
    wget \
    unzip \
    bash && \
    [ ! -e /usr/bin/php ] || rm /usr/bin/php && \
    ln -s /usr/bin/php${PHP_VERSION} /usr/bin/php && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*

# Set up WordPress
WORKDIR /var/www
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    mv wordpress/* . && \
    rm -rf wordpress latest.zip

# Copy and configure WordPress setup script
COPY conf/wp-config-create.sh /usr/local/bin/wp-config-create.sh
RUN chmod +x /usr/local/bin/wp-config-create.sh && \
    /usr/local/bin/wp-config-create.sh

# Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy user setup script
COPY conf/user.sh /usr/local/bin/user.sh
RUN chmod +x /usr/local/bin/user.sh

# Expose PHP-FPM port
EXPOSE 9000

# Set entrypoint and CMD
ENTRYPOINT ["/usr/local/bin/user.sh"]
CMD ["php-fpm${PHP_VERSION}", "--nodaemonize"]

