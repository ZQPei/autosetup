#!/bin/bash

function _auto_setup_main() {
  AUTOSETUP_HOME=$(cd $(dirname $0)/../ && pwd)
  echo ${AUTOSETUP_HOME}

  source ${AUTOSETUP_HOME}/tools/functional.sh

  # Use colors, but only if connected to a terminal, and that terminal
  # supports them.
  local ncolors=
  if type -P tput &>/dev/null; then
    ncolors=$(tput colors 2>/dev/null || tput Co 2>/dev/null || echo -1)
  fi

  local RED GREEN YELLOW BLUE BOLD NORMAL
  if [[ -t 1 && $ncolors && $ncolors -ge 8 ]]; then
    RED=$(tput setaf 1 2>/dev/null || tput AF 1 2>/dev/null)
    GREEN=$(tput setaf 2 2>/dev/null || tput AF 2 2>/dev/null)
    YELLOW=$(tput setaf 3 2>/dev/null || tput AF 3 2>/dev/null)
    BLUE=$(tput setaf 4 2>/dev/null || tput AF 4 2>/dev/null)
    BOLD=$(tput bold 2>/dev/null || tput md 2>/dev/null)
    NORMAL=$(tput sgr0 2>/dev/null || tput me 2>/dev/null)
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
  fi

  local install_opts install_prefix
  _auto_setup_readargs "$@"

  set -e

  # _auto_setup_min_apt_packages
  # _auto_setup_ohmyzsh
  _auto_setup_userfiles
  # _auto_setup_python

  unset AUTOSETUP_HOME
}

_auto_setup_main "$@" 5>&2
