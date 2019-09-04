FROM php:fpm-alpine

WORKDIR /code

RUN apk add \
        # for some composer packages
        git \
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

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp/composer
ENV PATH ./vendor/bin:/tmp/composer/vendor/bin:$PATH
