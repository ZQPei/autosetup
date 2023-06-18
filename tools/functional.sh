#!/bin/bash

##########################################################################
#
# Setup Base Working Environment for Linux
#
##########################################################################

function _auto_setup_readargs {
  install_opts=
  install_prefix=
  while (($#)); do
    local arg=$1; shift
    if [[ :$install_opts: != *:literal:* ]]; then
      case $arg in
      --dry-run)
        install_opts+=:${arg#--}
        continue ;;
      --)
        install_opts+=:literal
        continue ;;
      esac
    fi

    install_opts+=:error
    printf 'install (oh-my-bash): %s\n' "$RED$BOLD[Error]$NORMAL unrecognized argument '$arg'." >&2
  done
}

function _auto_setup_run {
  if [[ :$install_opts: == *:dry-run:* ]]; then
    printf '%s\n' "$BOLD$GREEN[dryrun]$NORMAL $BOLD$*$NORMAL" >&5
  else
    printf '%s\n' "$BOLD\$ $*$NORMAL" >&5
    command "$@"
  fi
}

function _auto_setup_min_apt_packages() {
  echo "install minimum apt packages"
  _auto_setup_run sudo apt update
  _auto_setup_run sudo apt install -y build-essential vim zsh ssh sshpass git net-tools tmux \
                      cmake gcc gcc-aarch64-linux-gnu g++-aarch64-linux-gnu \
                      libtinfo-dev zlib1g-dev libedit-dev libxml2-dev gfortran mlocate antlr4
  _auto_setup_run sudo apt upgrade
}

function _auto_setup_max_apt_packages() {
  echo "install maximum apt packages"
  _auto_setup_run sudo apt update
  _auto_setup_run sudo apt install -y build-essential vim zsh ssh sshpass git net-tools tmux libc6:i386 \
                      docker nfs-kernel-server nfs-common \
                      cmake gcc gcc-aarch64-linux-gnu g++-aarch64-linux-gnu \
                      python3 python3-dev python3-setuptools \
                      libtinfo-dev zlib1g-dev libedit-dev libxml2-dev gfortran mlocate \
                      libncurses5 libopenblas-dev antlr4
  _auto_setup_run sudo apt upgrade
}

function _auto_setup_ohmyzsh() {
  echo "install oh-my-zsh"

  _auto_setup_run sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &&
  _auto_setup_run cp -ar ${AUTOSETUP_HOME}/userfile/.oh-my-zsh/* ${HOME}/.oh-my-zsh &&
  _auto_setup_run cp ${AUTOSETUP_HOME}/userfile/setup_env.sh ${HOME}/setup_env.sh &&
  _auto_setup_run sed -i '/ZSH_THEME*/s/ZSH_THEME.*/ZSH_THEME=\"pzq\"/' ${HOME}/.zshrc &&
  _auto_setup_run echo -e '\n\nif [ -f $HOME/setup_env.sh ] || [ -h $HOME/setup_env.sh ]; then\n  source $HOME/setup_env.sh\nfi\n' >> ${HOME}/.zshrc
}

function _auto_setup_ohmybash() {
  echo "install oh-my-bash"

  TMPOSH=/tmp/oh-my-bash
  _auto_setup_run rm -rf ${TMPOSH} &&
  _auto_setup_run git clone -b main --depth=1 https://github.com/ZQPei/oh-my-bash.git ${TMPOSH} &&
  _auto_setup_run bash ${TMPOSH}/tools/install_local.sh &&
  _auto_setup_run rm -rf ${TMPOSH}
  unset TMPOSH
}


function _auto_setup_userfiles() {
  echo "setup custom user files"
  _auto_setup_run mkdir -p ${HOME}/pzq ${HOME}/pzq/Downloads ${HOME}/pzq/Workspace ${HOME}/local

  _auto_setup_run cp -ar \
    ${AUTOSETUP_HOME}/userfile/.vimrc \
    ${AUTOSETUP_HOME}/userfile/.tmux.conf.bash \
    ${AUTOSETUP_HOME}/userfile/.tmux.conf.zsh \
    ${AUTOSETUP_HOME}/userfile/.tmux.conf \
    ${HOME}/

  _auto_setup_run cp -ar \
      ${AUTOSETUP_HOME}/userfile/local/* \
      ${HOME}/local
}

function _auto_setup_python_env() {
  echo "download commenly used packages"
  # _auto_setup_run wget -c -P ${HOME}/Downloads https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-2019.10-Linux-x86_64.sh
  _auto_setup_run wget -c -P ${HOME}/Downloads https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh

  echo "install commenly used python packages"
  _auto_setup_run pip install -r ${AUTOSETUP_HOME}/userfile/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
}
