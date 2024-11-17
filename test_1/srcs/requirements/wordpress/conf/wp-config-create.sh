#!/bin/sh

# Define the path for the wp-config.php file
WP_CONFIG_PATH="/var/www/wp-config.php"

# Check if wp-config.php already exists to avoid overwriting it
if [ ! -f "$WP_CONFIG_PATH" ]; then
    # Create wp-config.php with database and site configurations
    cat <<EOF > $WP_CONFIG_PATH
<?php
// ** MySQL settings - pulled from environment variables ** //
define( 'DB_NAME', getenv('DB_NAME') );
define( 'DB_USER', getenv('DB_USER') );
define( 'DB_PASSWORD', getenv('DB_PASS') );
define( 'DB_HOST', 'mariadb' );  // Use the MariaDB Docker service name
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

define('FS_METHOD', 'direct');   // Avoids FTP prompts for uploads

// ** Redis settings (optional) ** //
define( 'WP_REDIS_HOST', 'redis' );  // Use the Redis Docker service name
define( 'WP_REDIS_PORT', 6379 );
define( 'WP_REDIS_TIMEOUT', 1 );
define( 'WP_REDIS_READ_TIMEOUT', 1 );
define( 'WP_REDIS_DATABASE', 0 );

// ** WordPress Database Table prefix ** //
\$table_prefix = 'wp_';

// ** WordPress debugging mode ** //
define( 'WP_DEBUG', false );

// ** Absolute path to the WordPress directory ** //
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

// ** Sets up WordPress vars and included files ** //
require_once ABSPATH . 'wp-settings.php';
EOF

    echo "wp-config.php created successfully."
else
    echo "wp-config.php already exists; skipping creation."
fi

