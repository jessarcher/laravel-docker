FROM php:fpm-alpine

WORKDIR /code

RUN apk add \
        # for installing some composer packages
        git \
        # for building assets
        npm \
        # for zip extension
        libzip-dev \
        zlib-dev \
        # for intl extension
        icu-dev \
    && \
    docker-php-ext-install \
        bcmath \
        intl \
        pdo_mysql \
        pcntl \
        zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_HOME=/tmp/composer \
    PATH=./vendor/bin:/tmp/composer/vendor/bin:$PATH
