#! /bin/bash
## author:quanchaolin
#Protocol Compiler Installation Of Linux
#download the package
cd /tmp
wget https://github.com/protocolbuffers/protobuf/releases/download/v3.17.3/protoc-3.17.3-linux-x86_64.zip
# 解压压缩包
unzip -d protoc-3.17.3 protoc-3.17.3-linux-x86_64.zip
mv protoc-3.17.3 /usr/local/bin
# 添加环境变量
# Add /usr/local/protoc-3.17.3/bin to the PATH environment variable.
cat >> /etc/profile <<EOF
export PATH=$PATH:/usr/local/bin/protoc-3.17.3/bin
EOF
# 配置完毕后，执行命令令其生效
source /etc/profile
# 打印版本
protoc --version