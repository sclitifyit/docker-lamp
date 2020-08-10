FROM php:7.3-apache 
RUN apt-get update \
    && apt-get install -y libzip-dev \
    && apt-get install -y zlib1g-dev \
    && apt-get install -y libpng-dev \
    && rm -rf /var/lib/apt/lists/*
COPY server.crt /etc/apache2/ssl/server.crt
COPY server.key /etc/apache2/ssl/server.key
COPY localhost.conf /etc/apache2/sites-enabled/localhost.conf
RUN docker-php-ext-install mysqli pdo pdo_mysql zip mbstring gd
RUN a2enmod rewrite
RUN a2enmod ssl
RUN service apache2 restart
