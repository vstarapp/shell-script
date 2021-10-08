#!bin/bash
#memory usr  内存监控脚本
mem_war_file=/tmp/mem_war.txt # 声明一个变量，用于保存输出日志的路径
mem_use=$(free -m | grep Mem | awk '{print $3}') # 声明一个变量，用于保存内存的已使用空间
mem_total=$(free -m | grep Mem | awk '{print $2}') # 声明一个变量，用于保存内存的总大小
mem_percent=$((mem_use * 100 / mem_total)) # 内存的已使用比例
echo "$mem_percent"%
if (($mem_percent > 80)); then
   echo "$(date +%F-%H-%M) mem: ${mem_percent}%" >$mem_war_file
   # 发送邮件，如果报：mail: command not found 需要安装：yum -y install mailx
   echo "$(date +%F-%H-%M) mem: ${mem_percent}%" | mail -s "mem warning" root
fi
