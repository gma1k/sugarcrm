FROM php:7.4-apache
RUN apt-get update && apt-get install -y \
    curl \
    git \
    libicu-dev \
    libpng-dev \
    libzip-dev \
    unzip \
    zip \
 && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install \
    gd \
    intl \
    mysqli \
    opcache \
    zip
RUN a2enmod rewrite
COPY php.ini /usr/local/etc/php/
COPY . /var/www/html
RUN chown -R www-data:www-data /var/www/html
EXPOSE 80
