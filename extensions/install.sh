#!/bin/bash
cd /tmp/extensions

if [ "${PHP_REDIS}" != "false" ]; then
    mkdir redis \
    && tar -xf redis-${PHP_REDIS}.tgz -C redis --strip-components=1 \
    && ( cd redis && phpize && ./configure && make clean && make -j && make install ) \
    && docker-php-ext-enable redis
fi

if [ "${PHP_SWOOLE}" != "false" ]; then
    mkdir swoole \
    && tar -xf swoole-${PHP_SWOOLE}.tgz -C swoole --strip-components=1 \
    && ( cd swoole && phpize && ./configure && make clean && make -j && make install ) \
    && docker-php-ext-enable swoole
fi