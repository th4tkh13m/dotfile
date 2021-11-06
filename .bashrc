#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/th4tkh13m/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/th4tkh13m/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/th4tkh13m/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/th4tkh13m/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

PS1='> '

#Environment Variables

#Java
export JAVA_HOME=/home/th4tkh13m/Java/jdk-17.0.1
export PATH=$PATH:$JAVA_HOME/bin

#Bitwarden
export BW_SESSION="477Q6W6UcJvTOFYJYmjFaDlCwPUPbW17mZjc8VXZuA2nS1pk9PqxiQn7Nv19XvJghQ0fkM0O7g1YEEFAs4k7AA=="
#Julia
export PATH=$PATH:/home/th4tkh13m/Julia/julia-1.6.3/bin
#Maven
export PATH=$PATH:/home/th4tkh13m/Maven/apache-maven-3.8.3/bin
#Others
export PATH=$PATH:$HOME/.bin

#Activate conda environment
conda activate myenv

#Mount using systemd-mount
alias data="systemd-mount --owner=th4tkh13m /dev/nvme0n1p6 ~/Data/"

export EDITOR=nvim
