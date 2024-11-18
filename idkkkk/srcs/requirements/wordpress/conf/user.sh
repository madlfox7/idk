#!/bin/sh

# Explicitly set the PHP binary path for wp-cli
export WP_CLI_PHP=/usr/bin/php

# Debugging
echo "PATH: $PATH"
echo "PHP binary: $WP_CLI_PHP"
which php || { echo "php not found"; exit 1; }
which wp || { echo "wp-cli not found"; exit 1; }

# Install WordPress core
wp core install --url=localhost --title="inception" --admin_user="${WP_ADMIN_USR}" --admin_password="${WP_ADMIN_PWD}" --admin_email="${WP_ADMIN_EMAIL}"

# Check if user exists, and create if not
if wp user get "${WP_USR}" >/dev/null 2>&1; then
    echo "User ${WP_USR} exists."
else
    wp user create "${WP_USR}" "${WP_EMAIL}" --role=subscriber --user_pass="${WP_PWD}"
fi

# Update password for user 'ksudzilo'
wp user update "ksudzilo" --user_pass="${WP_PWD}" --skip-email

# Activate theme
wp theme activate twentytwentytwo

# Start PHP-FPM
/usr/sbin/php-fpm81 -F

