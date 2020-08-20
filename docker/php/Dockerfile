FROM php:7.3-apache 
RUN apt-get update \
    && apt-get -y install tzdata cron curl \
    && apt-get install -y libzip-dev \
    && apt-get install -y zlib1g-dev libicu-dev g++ \
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev libwebp-dev wget sendmail \
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

# Modify apache config
RUN a2enmod rewrite && \
    a2enmod expires && \
    a2enmod headers
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

# Sendmail
RUN echo "sendmail_path=/usr/sbin/sendmail -t -i" >> /usr/local/etc/php/conf.d/sendmail.ini 
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install zip
RUN sed -i '/#!\/bin\/sh/aservice sendmail restart' /usr/local/bin/docker-php-entrypoint
RUN sed -i '/#!\/bin\/sh/aecho "$(hostname -i)\t$(hostname) $(hostname).localhost" >> /etc/hosts' /usr/local/bin/docker-php-entrypoint

#CRONS
RUN cp /usr/share/zoneinfo/Europe/Bucharest /etc/localtime && \
    echo "Europe/Bucharest" > /etc/timezone
#RUN apt-get -y remove tzdata
RUN rm -rf /var/cache/apk/*
# Copy cron file to the cron.d directory
COPY cron /etc/cron.d/cron
# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/cron
# Apply cron job
RUN crontab /etc/cron.d/cron
# Create the log file to be able to run tail
RUN mkdir -p /var/log/cron
# Add a command to base-image entrypont scritp
RUN sed -i 's/^exec /service cron start\n\nexec /' /usr/local/bin/apache2-foreground

# And clean up the image
RUN rm -rf /var/lib/apt/lists/*

# Apache Restart
RUN service apache2 restart
