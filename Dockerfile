FROM ubuntu:12.04
ENV ENVIRONMENT docker
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data
RUN apt-get update && apt-get install -y apt-transport-https
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-get update -y --force-yes && \
    apt-get install -y --force-yes --no-install-recommends \ 
      apache2 \
      git \
      mercurial \
      nano \
      php5-cli \
      libapache2-mod-php5 \
      php5-gd \
      php5-json \
      php5-ldap \
      php5-mysql \
      php5-pgsql \
      php5-sqlite \
      php-pear \
      php-apc \
      php5-curl \
      php5-xdebug \
      php5-intl \
      php5-mcrypt \
      curl lynx-cur \
      && rm -rf /var/lib/apt/lists/* \
      && apt-get clean -y

RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php5/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php5/apache2/php.ini
RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer
