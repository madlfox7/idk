#!/bin/sh

# Install WordPress
wp core install --url="${WP_URL}" --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN_USR}" --admin_password="${WP_ADMIN_PWD}" \
    --admin_email="${WP_ADMIN_EMAIL}" --allow-root

# Create the secondary user
wp user create "${WP_USR}" "${WP_EMAIL}" \
    --role=subscriber --user_pass="${WP_PWD}" --allow-root

# Start PHP-FPM to keep the container running
exec php-fpm82 --nodaemonize

