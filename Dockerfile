FROM php:7.3-apache 
RUN apt-get update \
    && apt-get install -y libzip-dev \
    && apt-get install -y zlib1g-dev libicu-dev g++ \
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev libwebp-dev \
    && rm -rf /var/lib/apt/lists/*
COPY server.crt /etc/apache2/ssl/server.crt
COPY server.key /etc/apache2/ssl/server.key
COPY localhost.conf /etc/apache2/sites-enabled/localhost.conf
# GD With Enabled JPEG Support.
RUN docker-php-ext-configure gd \
    --with-gd \
    --with-webp-dir \
    --with-jpeg-dir \
    --with-png-dir \
    --with-zlib-dir \
    --with-freetype-dir
RUN docker-php-ext-install mysqli pdo_mysql zip gd exif
# Enable Apache rewrite module.
RUN a2enmod rewrite
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
# Install PECL Uploadprogress.
RUN pecl install uploadprogress \
  && echo 'extension=uploadprogress.so' > /usr/local/etc/php/conf.d/uploadprogress.ini
# Install imagick.
RUN apt-get update && apt-get install -y \
    libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick
# Enable SSL Cert
RUN a2enmod ssl
RUN service apache2 restart
