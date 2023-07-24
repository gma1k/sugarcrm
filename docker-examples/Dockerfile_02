FROM php:7.4-apache

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libfreetype6-dev \
    libgmp-dev \
    libicu-dev \
    libimap-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxml2-dev \
    libzip-dev \
    unzip \
    zip \
 && docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install -j$(nproc) bcmath curl gd gmp imap intl json mbstring mysqli opcache soap zip

COPY sugarcrm /var/www/html/

RUN chown -R www-data:www-data /var/www/html/ \
 && chmod -R 755 /var/www/html/ \
 && chmod -R 775 /var/www/html/cache /var/www/html/custom /var/www/html/data /var/www/html/modules /var/www/html/upload

ENV HTTP_PROXY=http://proxy.example.com:8080
ENV HTTPS_PROXY=http://proxy.example.com:8080

ENV DB_HOST=mysql.example.com
ENV DB_PORT=3306
ENV DB_NAME=sugarcrm
ENV DB_USER=sugarcrm
ENV DB_PASSWORD=sugarcrm

EXPOSE 80
