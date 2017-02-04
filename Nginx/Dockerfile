# ######################### #
# Dockefile Debian8         #    
# Nginx for Zabbix	    #
# ######################### #

# Set the base image 
FROM debian:jessie
MAINTAINER Andrew 

# Install Locale, add nginx repository  and install nginx.

ENV DEBIAN_FRONEND noninteractive
ENV LANG    en_US.UTF8
RUN apt-get update  &&  apt-get install -qy openssl locales curl tar gzip unzip wget telnet vim \
    && echo "deb http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list.d/nginx.list \
    && echo "deb-src http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list.d/nginx.list \
    && mkdir -p /tmp/nginx-key && wget -P  /tmp/nginx-key http://nginx.org/keys/nginx_signing.key \
    && apt-key add /tmp/nginx-key/nginx_signing.key \
    && apt-get update && apt-get install -qy nginx \
    && mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf_orig \
    && mkdir -p  /etc/nginx/vhost/zabbix \
    && echo "daemon off;" >> /etc/nginx/nginx.conf \
    && sed -i "32i  include /etc/nginx/vhost/*/*.conf;" /etc/nginx/nginx.conf \
    && locale-gen  ${LANG} \
    && mv /etc/localtime /etc/localtime_old \
    && ln -s /usr/share/zoneinfo/Eurepo/Kiev /etc/localtime


ADD zabbix-nginx.conf /etc/nginx/vhost/zabbix/zabbix.conf	 


EXPOSE  80 443
CMD  ["/usr/sbin/nginx"]
