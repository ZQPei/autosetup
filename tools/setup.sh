#!/bin/bash

##########################################################################
#
# Setup Base Working Environment for Linux
#
##########################################################################

function setup_min_apt_packages() {
  echo "install minimum apt packages"
  sudo apt update
  sudo apt install -y build-essential vim zsh ssh sshpass git net-tools tmux \
                      cmake gcc gcc-aarch64-linux-gnu g++-aarch64-linux-gnu \
                      libtinfo-dev zlib1g-dev libedit-dev libxml2-dev gfortran mlocate antlr4
  sudo apt upgrade
}

function setup_max_apt_packages() {
  echo "install maximum apt packages"
  sudo apt update
  sudo apt install -y build-essential vim zsh ssh sshpass git net-tools tmux libc6:i386 \
                      docker nfs-kernel-server nfs-common \
                      cmake gcc gcc-aarch64-linux-gnu g++-aarch64-linux-gnu \
                      python3 python3-dev python3-setuptools \
                      libtinfo-dev zlib1g-dev libedit-dev libxml2-dev gfortran mlocate \
                      libncurses5 libopenblas-dev antlr4
  sudo apt upgrade
}

function setup_ohmyzsh() {
  echo "install oh-my-zsh"

  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  cp -r ${AUTOSETUP_HOME}/userfile/.oh-my-zsh/* ${HOME}/.oh-my-zsh
}

function setup_ohmybash() {
  echo "install oh-my-bash"

  TMPOSH=/tmp/oh-my-bash && rm -rf ${TMPOSH} && git clone -b main --depth=1 https://github.com/ZQPei/oh-my-bash.git ${TMPOSH} && bash ${TMPOSH}/tools/install_local.sh && rm -rf ${TMPOSH}
}


function setup_userfiles() {
  echo "setup custom user files"
  mkdir -p ${HOME}/pzq ${HOME}/pzq/Downloads ${HOME}/pzq/Workspace ${HOME}/local

  cp -ar \
    ${AUTOSETUP_HOME}/userfile/.vimrc \
    ${AUTOSETUP_HOME}/userfile/.tmux.conf.bash \
    ${AUTOSETUP_HOME}/userfile/.tmux.conf.zsh \
    ${AUTOSETUP_HOME}/userfile/.tmux.conf \
    ${HOME}/

  cp -ar \
      ${AUTOSETUP_HOME}/userfile/local/* \
      ${HOME}/local
}

function setup_python_env() {
  echo "download commenly used packages"
  # wget -c -P ${HOME}/Downloads https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-2019.10-Linux-x86_64.sh
  wget -c -P ${HOME}/Downloads https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh

  echo "install commenly used python packages"
  pip install -r ${AUTOSETUP_HOME}/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
}

function main() {
  AUTOSETUP_HOME=$(cd $(dirname $0) && pwd)
  echo ${AUTOSETUP_HOME}
  setup_min_apt_packages
  setup_ohmybash
  setup_userfiles
  # setup_python
}

main $@
