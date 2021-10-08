#!bin/bash
#memory usr  内存监控脚本
mem_war_file=/tmp/mem_war.txt
mem_use=`free -m | grep Mem | awk '{print $3}'`
mem_total=`free -m | grep Mem | awk '{print $2}'`
mem_percent=$((mem_use*100/mem_total))
echo "$mem_percent"%
if (($mem_percent > 80));then
   echo "`date +%F-%H-%M` mem: ${mem_percent}%" >$mem_war_file
   echo "`date +%F-%H-%M` mem: ${mem_percent}%" | mail -s "mem warning" root 
fi