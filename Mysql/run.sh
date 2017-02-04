#!/bin/bash 
DATA=/var/lib/mysql
COMMAND=/usr/sbin/mysqld


if [ ! -f  ${DATA}/ibdata1 ];then

	echo  "Start install mysql DB ...." 
	${COMMAND} --no-defaults --initialize-insecure --datadir=${DATA} --user=mysql
	sleep 2
 
 	


	echo  "Start mysql server temporarily"

	${COMMAND} --basedir=/usr --datadir=${DATA} --plugin-dir=/usr/lib/mysql/plugin  --user=mysql &
	MPID=$!
	MYSQL=`which mysql`

	echo ""
	echo "Mysql init process is starting...Waiting...**"
	sleep 10

	if  [ ! -z $MPID ]; then

	echo  "** CREATE zabbix db and zabbix user"
${MYSQL} <<-EOF
CREATE DATABASE zabbix;
CREATE USER 'zabbix'@'%' IDENTIFIED BY 'zabbixpasswd';
GRANT ALL ON zabbix.* TO 'zabbix'@'%';
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
EOF
		echo "** Mysql ZabbixDB created successfully : ${MPID}"

		if ! kill -15 ${MPID}; then
			echo >&2 "** Mysql process failed."
			exit 1
		fi
	else 
		echo "**ERROR: Could start mysql server"
		exit 1
	fi

	echo ""
	echo "** Mysql temporary process has finished. Mysql is ready to run."
	echo "" 

	chown mysql:mysql ${DATA}
else 
	"**INFO: Mysql has already initialized"
fi

echo "**INFO: Starting mysql server..."
exec  ${COMMAND} --basedir=/usr --datadir=${DATA} --plugin-dir=/usr/lib/mysql/plugin  --user=mysql 
