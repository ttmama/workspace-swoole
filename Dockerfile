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
	git \
	curl \
	vim \
	nano \
	postgresql-client \
	&& apt-get clean \
&& pecl install swoole \
&& docker-php-ext-enable swoole

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