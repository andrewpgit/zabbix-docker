# ######################### #
# Dockefile Debian8         #    
#  php5-fpm 		    #
# ######################### #

# Set the base image 
FROM debian:jessie
MAINTAINER Andrew 

ENV DEBIAN_FRONEND noninteractive
ENV LANG    en_US.UTF8


RUN apt-get update -y  \
    && apt-get install -y openssl curl locales tar gzip unzip vim wget telnet \
    && apt-get install -y php5-fpm php5-cgi php5-cli php5-common php5-curl php5-gd php5-intl php5-json php5-mcrypt php5-mysql php5-readline php5-xcache php5-xsl \
    && sed -i "s/;date.timezone =/date.timezone = Europe\/Kiev/" /etc/php5/fpm/php.ini \
    && sed -i "s/;date.timezone =/date.timezone = Europe\/Kiev/" /etc/php5/cli/php.ini \
    && sed -i "s/;daemonize\s*=\s*yes/daemonize = no/" /etc/php5/fpm/php.ini \
    && sed -i "s/;daemonize\s*=\s*yes/daemonize = no/" /etc/php5/fpm/php-fpm.conf \
    && sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/cli/php.ini \
    && sed -i "s/;always_populate_raw_post_data =.*/always_populate_raw_post_data = -1/" /etc/php5/fpm/php.ini \
    && sed -i "s/max_execution_time = .*/max_execution_time = 300/" /etc/php5/fpm/php.ini \
    && sed -i "s/max_input_time = .*/max_input_time = 300/" /etc/php5/fpm/php.ini \
    && sed -i "s/post_max_size = .*/post_max_size = 16M/" /etc/php5/fpm/php.ini \
    && sed -i "s/memory_limit = .*/memory_limit = 128M/"          /etc/php5/fpm/php.ini \
    && sed -i "s/pid = .*/pid = \/var\/run\/php-fpm.pid/"          /etc/php5/fpm/php-fpm.conf \
    && locale-gen ${LANG} \
    && mv /etc/php5/fpm/pool.d/www.conf /etc/php5/fpm/pool.d/www.conf_orig \
    && mv /etc/localtime /etc/localtime_old \
    && ln -s /usr/share/zoneinfo/Eurepo/Kiev /etc/localtime \
# Install Zabbix-frontend
    &&  mkdir /tmp/zabbix  \
    &&  wget -P /tmp/zabbix http://repo.zabbix.com/zabbix/3.2/debian/pool/main/z/zabbix-release/zabbix-release_3.2-1+jessie_all.deb \
    &&  dpkg -i /tmp/zabbix/*.deb  &&  apt-get update \
    &&  apt-get install -qy  --no-install-recommends  zabbix-frontend-php \
    &&  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD www.conf /etc/php5/fpm/pool.d/www.conf

CMD ["php5-fpm", "-F"]
