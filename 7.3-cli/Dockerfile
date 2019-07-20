ARG PHP_VERSION=7.3
ARG PHP_TYPE=cli

FROM php:${PHP_VERSION}-${PHP_TYPE}

RUN apt-get update && apt-get install -y \
        libzip-dev \
        zlib1g-dev \
        libicu-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) bcmath \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-install -j$(nproc) zip \
    && docker-php-ext-install -j$(nproc) pdo \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install -j$(nproc) mysqli \
    && docker-php-ext-install -j$(nproc) gd \
    && apt-get clean -y

RUN apt-get update && apt-get install -y \
        libyaml-dev \
    && pecl install yaml \
    && docker-php-ext-enable yaml \
    && apt-get clean -y

