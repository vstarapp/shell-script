#! /bin/bash
## author:quanchaolin
## install golang for Linux系统下安装Go
# cd到临时目录
cd /tmp

# 下载Go
wget https://golang.google.cn/dl/go1.16.7.linux-amd64.tar.gz

# 下载好之后解压并移动到/usr/local
# Extract the archive you downloaded into /usr/local, creating a Go tree in /usr/local/go.
# Important: This step will remove a previous installation at /usr/local/go, if any, prior to extracting. Please back up any data before proceeding.

# For example, run the following as root or through sudo:
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.7.linux-amd64.tar.gz

# 添加环境变量GOROOT和GOBIN添加到PATH中
# Add /usr/local/go/bin to the PATH environment variable.
# You can do this by adding the following line to your $HOME/.profile or /etc/profile (for a system-wide installation):
cat >> /etc/profile <<EOF
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
EOF

# 添加环境变量GIOPATh(可按照实际情况设置目录)
# 工作区是什么？
# 这是go中一个非常重要的概念，在一般情况下，go源文件必须放在工作区中，也就是说，我们写的项目代码都必须放在我们设定的工作区中，虽然对于命令源码来说，这不是必须的。
# 但我们大多数都是前一种情况。工作区其实就是一个对应特定的工程目录，它应包含3个子目录src目录、pkg目录、bin目录
#src：用于以代码包的形式组织并保存go源码文件
# pkg:用于存放通过 go install 命令安装后的代码包的归档文件（.a 结尾的文件）
# bin:与pkg目录类似，在通过 go install 命令完成安装后，保存由go命令源码文件生成的可执行文件
cat >> /etc/profile <<EOF
export GOPATH=/usr/local/go/path
EOF
# 配置完毕后，执行命令令其生效
source /etc/profile
# 打印版本
go version
