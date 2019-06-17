#!/bin/bash
#mysql5.6安装脚本，要求安装包与脚本以及初始配置文件同在/usr/local/路径下
echo ==========add user mysql================
groupadd mysql
useradd -r -g mysql mysql
tar -zxvf mysql-5.6.41-linux-glibc2.12-x86_64.tar.gz
echo =========compiling mysql===============
mv mysql-5.6.41-linux-glibc2.12-x86_64 mysql
mv /etc/my.cnf /etc/my.cnf_bak
mv my.cnf /etc/my.cnf
mv mysql-5.6.41-linux-glibc2.12-x86_64 mysql
cd mysql
./scripts/mysql_install_db --user=mysql
ln -s /usr/local/mysql/support-files/mysql.server /usr/bin/mysql.server
mv /usr/bin/mysqladmin /usr/bin/mysqladmin_bak
ln -s /usr/local/mysql/bin/mysqladmin /usr/bin/mysqladmin
ln -s /usr/local/mysql/bin/mysql /usr/bin/mysql
echo ==========starting mysql===============
cd support-files
mysql.server start
sleep 3
pro=`ps -ef | grep mysql | grep -v grep |wc -l`
if [ $pro -ne 0 ];then
	echo 'mysql has been started!'
fi
ln -s /var/lib/mysql/mysql.sock /tmp/mysql.sock
#mysqladmin -uroot password '51..dmz' || exit
echo 'Please set the password for the local user.'
