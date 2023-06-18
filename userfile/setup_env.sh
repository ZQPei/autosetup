#!/usr/bin/env bash

# for umask
umask 002

# for aliases
alias ll="ls -alh"
alias huster="nohup build_server --port 8887 --base_dir / >> /dev/null 2>&1 & ;"
alias py37="source /opt/adlab/python37/bin/activate" 
alias torch15="conda activate torch1.5"


if [[ ${SHELL} =~ "zsh" ]]; then
    # key bindings
    bindkey "\e[1~" beginning-of-line
    bindkey "\e[4~" end-of-line
    bindkey "\e[5~" beginning-of-history
    bindkey "\e[6~" end-of-history
    bindkey "\e[3~" delete-char
    bindkey "\e[2~" quoted-insert
    bindkey "\e[5C" forward-word
    bindkey "\eOc" emacs-forward-word
    bindkey "\e[5D" backward-word
    bindkey "\eOd" emacs-backward-word
    bindkey "\ee[C" forward-word
    bindkey "\ee[D" backward-word
    bindkey "^H" backward-delete-word
    # for rxvt
    bindkey "\e[8~" end-of-line
    bindkey "\e[7~" beginning-of-line
    # for non RH/Debian xterm, can't hurt for RH/DEbian xterm
    bindkey "\eOH" beginning-of-line
    bindkey "\eOF" end-of-line
    # for freebsd console
    bindkey "\e[H" beginning-of-line
    bindkey "\e[F" end-of-line
    # completion in the middle of a line
    bindkey '^i' expand-or-complete-prefix

    # for sync zsh history
    setopt inc_append_history
    setopt share_history
    # setopt noincappendhistory
    # setopt nosharehistory

    alias src="source ~/.zshrc"

elif [[ ${SHELL} =~ "bash" ]]; then
    # export PROMPT_COMMAND="history -a; history -n"
    alias src="source ~/.bashrc"
fi
