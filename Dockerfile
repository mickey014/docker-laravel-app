FROM php:8.1-fpm

# Install dependencies
RUN apt-get update && apt-get install -y  \
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libwebp-dev \
    --no-install-recommends \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql -j$(nproc) gd \
    && docker-php-ext-install opcache

# Setting up opcache.ini
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0"
ADD ./docker/php/opcache.ini "$PHP_INI_DIR/conf.d/opcache.ini"

# Nginx configuration
COPY ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf
