# ######################### #
# Dockefile Debian8         #
# Zabbix 3 		    #
# ######################### #

# Set the base image
FROM debian:jessie
MAINTAINER Andrew

# Add latest zabbix repository and install zabbix-server

ENV DEBIAN_FRONEND noninteractive
ENV LANG    en_US.UTF8
ENV LC_ALL  en_US.UTF8

## Install zabbix-server 
RUN     apt-get update  &&  apt-get install -qy openssl locales curl tar gzip unzip wget telnet vim \  
    &&  locale-gen  $LC_ALL \
    &&  mkdir /tmp/zabbix \
    &&  wget -P /tmp/zabbix http://repo.zabbix.com/zabbix/3.2/debian/pool/main/z/zabbix-release/zabbix-release_3.2-1+jessie_all.deb \
    &&  dpkg -i  /tmp/zabbix/*.deb  &&  apt-get update \  
    &&  apt-get install -qy  --no-install-recommends  zabbix-server-mysql zabbix-get \
    &&  mv /etc/zabbix/zabbix_server.conf /etc/zabbix/zabbix_server.conf_old 

ADD  zabbix_server.conf  /etc/zabbix/zabbix_server.conf
ADD  db-create.sh  /usr/local/bin/start.sh 
RUN     chmod +x  /usr/local/bin/start.sh
#RUN  /bin/bash -c /tmp/db-create.sh
EXPOSE  10051
USER    zabbix
#ENTRYPOINT  ["/usr/sbin/zabbix_server" ] 
#CMD         [ "/usr/sbin/zabbix_server", "--foreground"]
CMD   ["/usr/local/bin/start.sh"]
