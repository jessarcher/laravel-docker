FROM php:latest

RUN apt-get update -yqq && \
    apt-get install gnupg -yqq && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install \
        git \
        nodejs \
        libcurl4-gnutls-dev \
        libicu-dev \
        libmcrypt-dev \
        libvpx-dev \
        libjpeg-dev \
        libpng-dev \
        libxpm-dev \
        zlib1g-dev \
        libfreetype6-dev \
        libxml2-dev \
        libexpat1-dev \
        libbz2-dev \
        libgmp3-dev \
        libldap2-dev \
        unixodbc-dev \
        libpq-dev \
        libsqlite3-dev \
        libaspell-dev \
        libsnmp-dev \
        libpcre3-dev \
        libtidy-dev \
        libzip-dev \
        -yqq && \
    pecl install xdebug && \
    docker-php-ext-install mbstring pdo_mysql curl json intl gd xml zip bz2 opcache bcmath pcntl && \
    docker-php-ext-enable xdebug && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install composer
ENV COMPOSER_HOME /composer
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

# Install PHP_CodeSniffer
RUN composer global require "squizlabs/php_codesniffer=*"
