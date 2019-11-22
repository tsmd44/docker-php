ARG PHP_VERSION
FROM php:${PHP_VERSION}

RUN set -xe && \
    apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/v3.10/main/ \
      icu \
      glib \
      libxrender \
      libxext \
      fontconfig \
      libpng \
      libjpeg-turbo \
      libssl1.1 \
      libcrypto1.1 && \
    apk add --no-cache --virtual .php-deps \
      make && \
    apk add --no-cache --virtual .build-deps \
      $PHPIZE_DEPS \
      zlib-dev \
      icu-dev \
      libpng-dev \
      libjpeg-turbo-dev \
      oniguruma-dev \
      g++ && \
    docker-php-ext-configure \
      intl && \
    docker-php-ext-configure \
      gd --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install \
      pdo_mysql \
      intl \
      gd && \
    apk del \
      .php-deps \
      .build-deps && \
    rm -rf /tmp/* /usr/local/lib/php/doc/* /var/cache/apk/*
