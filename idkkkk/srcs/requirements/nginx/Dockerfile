FROM alpine:3.19

# Update and install Nginx and OpenSSL
RUN apk update && apk upgrade && \
    apk add --no-cache nginx openssl

# Create necessary directories
RUN mkdir -p  /etc/ssl/  /var/www/

# Copy SSL certificate and key
COPY ./tools/ksudzilo.42.fr.crt /etc/nginx/ssl/ksudzilo.42.fr.crt
COPY ./tools/ksudzilo.42.fr.key /etc/nginx/ssl/ksudzilo.42.fr.key

# Copy Nginx configuration and website content
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
#COPY ./index.html /var/www/index.html

# Set proper permissions for SSL files
#RUN chmod 600 /etc/ssl/nginx/ksudzilo.42.fr.key
#RUN chmod 644 /etc/ssl/nginx/ksudzilo.42.fr.crt

# Ensure the private directory is not 
# Expose HTTPS port
EXPOSE 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

