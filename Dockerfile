FROM php:fpm-alpine

WORKDIR /code

RUN apk add \
        # for zip
        libzip-dev \
        zlib-dev \
        # for intl
        icu-dev \
    && \
    docker-php-ext-install \
        bcmath \
        intl \
        pdo_mysql \
        zip

ENV COMPOSER_HOME=./.composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
