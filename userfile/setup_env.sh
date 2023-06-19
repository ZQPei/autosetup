#!/usr/bin/env bash


# for umask
umask 002

# for aliases
alias ll="ls -alh"
alias huster="nohup build_server --port 8887 --base_dir / >> /dev/null 2>&1 & ;"
alias py37_env="source /opt/adlab/python37/bin/activate"
alias py37="conda activate py37"
alias set_env="source ${HOME}/local/bin/setup_tvm_env.sh"


if [[ ${SHELL} =~ "zsh" ]]; then
    # bind keys
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
#     export PROMPT_COMMAND="history -a; history -n"
    alias src="source ~/.bashrc"
fi

if [[ $AILICE_DOCKER_ENV = "True" ]]; then

# for local
export PATH=${ADLAB_HOME}/local/bin:${PATH}
export LD_LIBRARY_PATH=${ADLAB_HOME}/local/lib:${LD_LIBRARY_PATH}

# for cuda
export CUDA_HOME=/usr/local/cuda
export PATH=${CUDA_HOME}/bin:${PATH}
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64:${CUDA_HOME}/compat:${LD_LIBRARY_PATH}

# for libtorch
export LIBTORCH_HOME=${ADLAB_HOME}/local/libtorch
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${LIBTORCH_HOME}/lib

source /opt/adlab/python37/bin/activate

else

# added by Anaconda3 installer
# export PATH="/home/pzq/anaconda3/bin:$PATH"
# activate conda base environment
# . /home/pzq/anaconda3/etc/profile.d/conda.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/pzq/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/pzq/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/pzq/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/pzq/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/pzq/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/pzq/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/pzq/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/pzq/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# activate conda env
conda activate py37

# for local
export PATH=${HOME}/local/bin:/opt/adlab/local/bin:${PATH}
export LD_LIBRARY_PATH=${HOME}/local/lib:${LD_LIBRARY_PATH}

# for cuda
export CUDA_HOME=/usr/local/cuda
export PATH=${HOME}/local/bin:/usr/local/bin:${CUDA_HOME}/bin:${PATH}
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}

# for aliases
alias hpc-pzq="ssh pzq@30.220.136.117"

function auto_connect() {
    for line in $(cat ~/setup_env.sh | grep ssh); do
        if [[ $line =~ '@' ]]; then
            address=${line//\"/}
            if [[ $line =~ pzq ]]; then
              password=MhxzKhl
            else
              password=alibaba-inc
            fi
            echo "connect $address"
            echo expect -c "
              spawn ssh-copy-id $address
              expect {
                \"*assword\" {set timeout 30; send \"$password\r\";}
                \"yes/no\"  {send \"yes\r\"; exp_continue;}
              }
            expect eof"
        fi
    done
}

function docker_run_hint() {
    echo 'docker run -itd --gpus all -u administrator:administrator --privileged --name py37_pth171_cuda112_cudnn811_ubuntu1804 -e HOME=/home/administrator -w /home/administrator -v /home/administrator:/home/administrator -v /home/administrator/workspace:/home/administrator/workspace -v /etc/localtime:/etc/localtime:ro -v /tmp/.x11-unix:/tmp/.x11-unix -e DISPLAY=unix$DISPLAY --net=host reg.docker.alibaba-inc.com/computing_platform/ailice:py37_pth171_cuda112_cudnn811_ubuntu1804'
    echo 'docker run -itd --gpus all -u administrator:administrator --privileged --name py37_pth150_cuda112_cudnn811_ubuntu1804 \
                    -e HOME=/home/administrator \
                    -w /home/administrator \
                    -v /home/pzq/Workspace:/home/administrator/Workspace \
                    -v /etc/localtime:/etc/localtime:ro \
                    -v /tmp/.x11-unix:/tmp/.x11-unix -e DISPLAY=unix$DISPLAY \
                    --net=host \
                    reg.docker.alibaba-inc.com/computing_platform/ailice:py37_pth150_cuda112_cudnn811_ubuntu1804'
    echo 'docker run -itd --gpus all -u pzq:administrator --privileged --name py37_pth171_cuda112_cudnn811_ubuntu1804_pzq \
                    -e HOME=/home/pzq \
                    -w /home/pzq -v /home/pzq:/home/pzq \
                    -v /home/pzq/Workspace:/home/pzq/Workspace \
                    -v /etc/localtime:/etc/localtime:ro \
                    -v /tmp/.x11-unix:/tmp/.x11-unix -e DISPLAY=unix$DISPLAY \
                    --net=host \
                    reg.docker.alibaba-inc.com/computing_platform/ailice:py37_pth171_cuda112_cudnn811_ubuntu1804'
}

function nsys_hint() {
    echo 'sudo -E LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/had_deps/lib/ nsys profile --trace=cuda,nvtx --backtrace=none --sample=none -o "/home/administrator/Workspace/tmp/`date +%F-%T`.qdrep" profile.sh'
}

fi
