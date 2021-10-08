#!bin/bash
# 检测MySQL主从复制是否异常
# 此脚本在从服务器执行
user="root"
password="Pwd@123456"
host="localhost"
mycmd="mysql -u$user -p$password -h$host"

function chkdb() {
    list=($($mycmd -e "show slave status \G" | egrep "Running|Behind" | awk -F: '{print $2}'))
    if [ ${list[0]} = "Yes" -a ${list[1]} = "Yes" -a ${list[2]} -lt 120 ]; then
        echo "Mysql slave is ok"
    else
        echo "Mysql slave replation is filed"
    fi
}

function main() {
    while true; do
        chkdb
        sleep 3
    done
}
main
