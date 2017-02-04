###################
# Zabbix  	  #
# DB PerconaDB	  #
###################

FROM centos:7

MAINTAINER Andrew

ENV RELEASEDB=percona-release-0.1-4.noarch.rpm 
  

# Add repository Percona and install DB
RUN    yum update -y && yum clean all \
    && yum install -y curl wget vim \
    && yum install -y http://www.percona.com/redir/downloads/percona-release/redhat/${RELEASEDB} \
    && yum install -y Percona-Server-server-57 Percona-Server-client-57 \
    && rm -rf  /var/lib/mysql/* \
    && mkdir /var/log/mysql  && chown mysql: /var/log/mysql
    



COPY run.sh /usr/local/bin/
ADD  my.cnf  /etc/my.cnf   

CMD ["/usr/local/bin/run.sh"]
