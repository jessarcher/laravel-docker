FROM php:latest

RUN apt-get update -yqq && \
    apt-get install gnupg -yqq && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install \
        git \
        libaspell-dev \
        libbz2-dev \
        libcurl4-gnutls-dev \
        libexpat1-dev \
        libfreetype6-dev \
        libgmp3-dev \
        libicu-dev \
        libjpeg-dev \
        libldap2-dev \
        libmcrypt-dev \
        libpcre3-dev \
        libpng-dev \
        libpq-dev \
        libsnmp-dev \
        libsqlite3-dev \
        libtidy-dev \
        libvpx-dev \
        libxml2-dev \
        libxpm-dev \
        libzip-dev \
        nodejs \
        npm \
        unixodbc-dev \
        unzip \
        zlib1g-dev \
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
