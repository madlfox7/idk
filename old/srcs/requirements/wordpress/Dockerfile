FROM alpine:3.19

# Install necessary packages
RUN apk update && apk add --no-cache \
    php81 php81-fpm php81-mysqli php81-json php81-curl php81-dom \
    php81-mbstring php81-openssl php81-xml php81-zip php81-fileinfo \
    php81-session php81-exif php81-gd wget unzip bash

# Configure PHP-FPM
RUN sed -i 's|listen = 127.0.0.1:9000|listen = 9000|' /etc/php81/php-fpm.d/www.conf

# Install WordPress
WORKDIR /var/www/html
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    mv wordpress/* . && \
    rm -rf wordpress latest.zip

# Expose PHP-FPM port
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm81", "--nodaemonize"]

