#!/bin/bash

##########################################################################
#
# Auto Setup the Base Working Environment for Linux
#
##########################################################################

AUTOSETUP_HOME=$(cd $(dirname $0) && pwd)
echo ${AUTOSETUP_HOME}

# 1. install required apt packages
echo "1. install required apt packages"

sudo apt update
sudo apt install -y build-essential zsh ssh sshpass git net-tools tmux libc6:i386 \
                    docker nfs-kernel-server nfs-common \
                    cmake gcc gcc-aarch64-linux-gnu g++-aarch64-linux-gnu \
                    python3 python3-dev python3-setuptools \
                    libtinfo-dev zlib1g-dev libedit-dev libxml2-dev gfortran mlocate libncurses5 libopenblas-dev antlr4
sudo apt upgrade


# 2. install oh-my-zsh and add custom theme
echo "2. install oh-my-zsh and add custom theme"

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cp -r ${AUTOSETUP_HOME}/userfile/.oh-my-zsh/* ${HOME}/.oh-my-zsh


# 3. copy custom user files to ~
echo "3. copy custom user files to ~"
mkdir ${HOME}/Downloads ${HOME}/Workspace ${HOME}/local

cp -r \
    ${AUTOSETUP_HOME}/userfile/.zshrc \
    ${AUTOSETUP_HOME}/userfile/.vimrc \
    ${AUTOSETUP_HOME}/userfile/.tmux.conf \
    ${HOME}/

cp -r \
    ${AUTOSETUP_HOME}/userfile/local/* \
    ${HOME}/local


# 4. download commenly used packages
echo "4. download commenly used packages"


wget -c -P ${HOME}/Downloads https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-2019.10-Linux-x86_64.sh


# 5. install commenly used python packages
echo "5. install commenly used python packages"

pip install -r ${AUTOSETUP_HOME}/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple



