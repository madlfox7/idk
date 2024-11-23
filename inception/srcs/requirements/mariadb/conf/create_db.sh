#!/bin/sh

# Initialize MySQL data directory if not initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    chown -R mysql:mysql /var/lib/mysql

    echo "[MariaDB] Initializing database..."
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm
fi

# Create the WordPress database and user if not exists
if [ ! -d "/var/lib/mysql/wordpress" ]; then
    echo "[MariaDB] Creating WordPress database and user..."
    cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY 'rootpass';
CREATE DATABASE wordpress CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER 'wpuser'@'%' IDENTIFIED BY 'wppass';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';
FLUSH PRIVILEGES;
EOF

    # Bootstrap MariaDB with the SQL script
    /usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db.sql
    rm -f /tmp/create_db.sql
else
    echo "[MariaDB] Database already initialized."
fi

# Start MariaDB
exec /usr/bin/mysqld --user=mysql --console

