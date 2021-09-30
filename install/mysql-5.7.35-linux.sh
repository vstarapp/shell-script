#! /bin/bash
## author:quanchaolin
## install mysql for Linux mysql rpm安装
# 删除旧包：
rpm -qa | grep -i mysql
rpm -ev mysql-libs-* --nodeps

# cd到临时目录
cd /tmp

# 下载安装文件
wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.35-1.el7.x86_64.rpm-bundle.tar
# 解压
sleep 5s
tar -xvf mysql-5.7.35-1.el7.x86_64.rpm-bundle.tar
# 安装依赖
sudo yum install libncurses*

# 安装rpm包：
rpm -ivh mysql-community-common-5.7.35-1.el7.x86_64.rpm
rpm -ivh mysql-community-libs-5.7.35-1.el7.x86_64.rpm
rpm -ivh mysql-community-client-5.7.35-1.el7.x86_64.rpm
rpm -ivh mysql-community-server-5.7.35-1.el7.x86_64.rpm
vim /usr/lib/tmpfiles.d/mysql.conf
# 卸载rpm包：
# rpm -e mysql-community-server-5.7.35-1.el7.x86_64
# rpm -e mysql-community-client-5.7.35-1.el7.x86_64
# rpm -e mysql-community-libs-5.7.35-1.el7.x86_64
# rpm -e mysql-community-common-5.7.35-1.el7.x86_64

# 启动、停止：

service mysqld start
# service mysqld stop
service mysqld status
systemctl enable mysqld

# 初始随机密码：

# cat /var/log/mysqld.log | more
grep "temporary password" /var/log/mysqld.log

# 修改初始密码及授权远程访问：

# mysql -uroot -p
# mysql> set password='Pwd@123456';
# mysql> grant all privileges on *.* to 'root'@'%' identified by 'Pwd@123456';

# 密码复杂度属性：

# mysql> set global validate_password_policy=0;

# 主从配置
# 在主服务器上操作
# vim /etc/my.cnf
# mstaer 主服务器的配置

# server-id=1 #配置server-id，让主服务器有唯一ID号
# log_bin=master-bin # 打开Mysql日志，日志格式为二进制
# log_bin_index=master-bin.index
# binlog_do_db=backend

#备注：

#server-id 服务器唯一标识。

#log_bin 启动MySQL二进制日志，即数据同步语句，从数据库会一条一条的执行这些语句。

#binlog_do_db 指定记录二进制日志的数据库，即需要复制的数据库名，如果复制多个数据库，重复设置这个选项即可。

#binlog_ignore_db 指定不记录二进制日志的数据库，即不需要复制的数据库名，如果有多个数据库，重复设置这个选项即可。

#其中需要注意的是，binlog_do_db和binlog_ignore_db为互斥选项，一般只需要一个即可

# ② 创建并授权slave mysql 用的复制帐号

# GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO slave@'192.168.%.%'IDENTIFIED BY 'Pwd@123456';

# 在Master的数据库执行show master status，查看主服务器二进制日志状态，位置号
# show master status

# 在从服务器上操作

# server-id=2
# relay-log=slave-relay-bin
# relay-log-index=slave-relay-bin.index

# change master to master_host='192.168.2.105',master_port=3306,master_user='slave',master_password='Pwd@123456',master_log_file='master-bin.000003',master_log_pos=1196;

# start slave;  # 启动复制线程，就是打开I/O线程和SQL线程；实现拉主的bin-log到从的relay-log上；再从relay-log写到数据库内存里

# ③ 查看从服务器状态

# 可使用SHOW SLAVE STATUS\G查看从服务器状态，如下所示，也可用show processlist \G查看当前复制状态：

# Slave_IO_Running: Yes #IO线程正常运行

# Slave_SQL_Running: Yes #SQL线程正常运行