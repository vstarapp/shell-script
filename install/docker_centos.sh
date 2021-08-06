#! /bin/bash
## author:quanchaolin
## Install Docker Engine on CentOS
# Uninstall old versions
# Older versions of Docker were called docker or docker-engine. If these are installed, uninstall them, along with associated dependencies.
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

# Set up the repository
# Install the yum-utils package (which provides the yum-config-manager utility) and set up the stable repository.
sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker Engine
# Install the latest version of Docker Engine and containerd, or go to the next step to install a specific version:

# sudo yum install docker-ce docker-ce-cli containerd.io

# To install a specific version of Docker Engine, list the available versions in the repo, then select and install:

# a. List and sort the versions available in your repo. This example sorts results by version number, highest to lowest, and is truncated:

yum list docker-ce --showduplicates | sort -r

# b. Install a specific version by its fully qualified package name, which is the package name (docker-ce) plus the version string (2nd column) starting at the first colon (:), up to the first hyphen, separated by a hyphen (-). For example, docker-ce-18.09.1.
sudo yum install docker-ce docker-ce-cli containerd.io

# Start Docker.
sudo systemctl start docker

#设置开机启动docker服务:
sudo systemctl enable docker