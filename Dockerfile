FROM php:7.1.1-cli
MAINTAINER zhipeng liu <zhipeng.liu@ittmom.com>
COPY ./sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y --force-yes\
	zlib1g-dev \
	pkg-config \
	libcurl4-openssl-dev \
	libedit-dev \
	libssl-dev \
	libxml2-dev \
	xz-utils \
	libsqlite3-dev \
	sqlite3 \
	libmemcached-dev \
	libz-dev \
	libpq-dev \
	libjpeg-dev \
	libpng12-dev \
	libfreetype6-dev \
	libmcrypt-dev \
	git \
	curl \
	vim \
	nano \
	postgresql-client \
	&& apt-get clean \
&& pecl install swoole \
&& docker-php-ext-enable swoole

# Install the PHP mcrypt extention
RUN docker-php-ext-install mcrypt

# Install the PHP pdo_mysql extention
RUN docker-php-ext-install pdo_mysql

# Install the PHP pdo_pgsql extention
RUN docker-php-ext-install pdo_pgsql

#####################################
# gd:
#####################################

# Install the PHP gd library
RUN docker-php-ext-configure gd \
        --enable-gd-native-ttf \
        --with-jpeg-dir=/usr/lib \
        --with-freetype-dir=/usr/include/freetype2 && \
    docker-php-ext-install gd

#####################################
# Composer:
#####################################

# Install composer and add its bin to the PATH.
RUN curl -s http://getcomposer.org/installer | php && \
    echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
    mv composer.phar /usr/local/bin/composer

# Source the bash
RUN . ~/.bashrc && \
	composer config -g repo.packagist composer https://packagist.phpcomposer.com