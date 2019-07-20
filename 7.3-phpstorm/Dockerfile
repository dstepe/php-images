ARG PHP_VERSION=7.3

FROM dstepe/php:${PHP_VERSION}-cli

ARG XDEBUG_VERSION=xdebug-beta

RUN apt-get update && apt-get install -y \
    wget \
    git \
    gpg \
    && apt-get clean -y

RUN pecl install ${XDEBUG_VERSION} \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt. Maybe a new version was released and you forgot to update the verification hash?'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer

RUN wget https://phar.io/releases/phive.phar && \
    wget https://phar.io/releases/phive.phar.asc && \
    gpg --no-tty --keyserver hkps.pool.sks-keyservers.net --recv-keys 0x9D8A98B29B2D5D79 && \
    gpg --no-tty --verify phive.phar.asc phive.phar && \
    chmod +x phive.phar && \
    mv phive.phar /usr/local/bin/phive

RUN mkdir phive && \
    cd phive && \
    phive --no-progress install --trust-gpg-keys 4AA394086372C20A phpunit@~8.0 && \
    phive --no-progress install --trust-gpg-keys E82B2FB314E9906E php-cs-fixer && \
    cp tools/* /usr/local/bin/ && \
    cd .. && rm -r phive

COPY bin/* /usr/local/bin/

ADD php.ini /usr/local/etc/php/php.ini

COPY phive/gpg /root/.phive/gpg
COPY bin/* /usr/local/bin/
COPY entrypoint.sh /entrypoint.sh

WORKDIR /opt/project

ENTRYPOINT ["/entrypoint.sh"]

CMD [""]
