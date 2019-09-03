FROM php:fpm-alpine

WORKDIR /code

RUN apk add \
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
        zip

ENV COMPOSER_HOME=./.composer
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
