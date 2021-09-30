#! /bin/bash
## author:quanchaolin
## install redis
#redis安装
#安装c编译器：
yum install gcc-c++
#进入到tmp目录：
cd /tmp
# 下载安装包：
wget https://download.redis.io/releases/redis-6.2.5.tar.gz

# 解压：
tar -zxvf redis-6.2.5.tar.gz

# 把redis移动到安装目录：
mv redis-6.2.5 /usr/local/redis

# 进入redis目录：
cd /usr/local/redis

# 使用make对解压的Redis文件进行编译：
make
# 启动服务端：src/redis-server
# 启动客户端：src/redis-cli

# redis设置开机启动：
# 方式一

# 1.设置redis.conf中daemonize为yes,确保守护进程开启,也就是在后台可以运行.(设置为yes后,启动时好像没有redis的启动界面,不知道为什么)

#vi编辑redis安装目录里面的redis.conf文件
# [root@localhost /]# vim /usr/local/redis/redis.conf
# 找到daemonize 
# 设置：daemonize yes

# 2.复制redis配置文件(启动脚本需要用到配置文件内容,所以要复制)

#1.在/etc下新建redis文件夹
# [root@localhost /]# mkdir /etc/redis
#2.把安装redis目录里面的redis.conf文件复制到/etc/redis/6379.conf里面,6379.conf是取的文件名称,启动脚本里面的变量会读取这个名称,所以要是redis的端口号改了,这里也要修改
# [root@localhost redis]# cp /usr/local/redis/redis.conf /etc/redis/6379.conf

# 3.复制redis启动脚本

#1.redis启动脚本一般在redis根目录的utils,如果不知道路径,可以先查看路径
# [root@localhost redis]# find / -name redis_init_script
# /usr/local/redis/utils/redis_init_script
#2.复制启动脚本到/etc/init.d/redis文件中
# [root@localhost redis]# cp /usr/local/redis/utils/redis_init_script /etc/init.d/redis

# 4.修改启动脚本参数
# [root@localhost redis]# vim /etc/init.d/redis
#在/etc/init.d/redis文件的头部添加下面两行注释代码,也就是在文件中#!/bin/sh的下方添加
# chkconfig: 2345 10 90  
# description: Start and Stop redis
# EXEC=/usr/local/redis/src/redis-server
# CLIEXEC=/usr/local/redis/src/redis-cli

# 5.启动redis

# 打开redis命令:service redis start

# 关闭redis命令:service redis stop

# 设为开机启动:chkconfig redis on

# 设为开机关闭:chkconfig redis off