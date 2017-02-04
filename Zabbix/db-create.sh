#!/bin/bash

DIR=/usr/share/doc/zabbix-server-mysql
FILE="create.sql.gz"

# Create the file .my.cnf
if  [ ! -f /tmp/.my.cnf ];then 
  echo "Create the file .my.cnf in /tmp" 
  cat >  /tmp/.my.cnf <<-EOF
[mysql]
user=zabbix
password=zabbixpasswd
host=mysqldb
EOF
fi


# Checking to connect to mysql server
for i in {100..0} ; do
   if  mysql --defaults-extra-file=/tmp/.my.cnf -Bse "select 1;" 2>/dev/null ; then
     break
   fi
     echo "INFO:Wait MYSQL DB Server"
     sleep 1 
done

# Check to tables are in the zabbixDB.

array=(`mysql --defaults-extra-file=/tmp/.my.cnf -Bse "show tables from zabbix;"`)

if [ "${array[0]}" = "" ];then
   
   echo "Create tables in the zabbixDB"
   echo "Start creating tables.Its take few minutes" 
   echo "" 
   cd ${DIR} && zcat ${FILE} | mysql --defaults-extra-file=/tmp/.my.cnf zabbix 
   echo "SQL finished"

else 

    echo "Tables have already created."

fi

 
exec /usr/sbin/zabbix_server --foreground 
