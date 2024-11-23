FROM alpine:3.19

# Install MariaDB
RUN apk update && apk add --no-cache mariadb mariadb-client

# Configure MariaDB
RUN mkdir /var/run/mysqld && \
    chmod 777 /var/run/mysqld && \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee /etc/my.cnf.d/docker.cnf && \
    sed -i "s|skip-networking|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf

# Expose MariaDB port
EXPOSE 3306

# Copy initialization script
COPY conf/create_db.sh /create_db.sh
RUN chmod +x /create_db.sh

# Run MariaDB
CMD ["sh", "/create_db.sh"]

