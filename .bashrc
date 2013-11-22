# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PATH=$PATH:$HOME/bin:/home/m20lib/binLinux
PATH=$PATH:/opt/CodeSourcery/Sourcery_CodeBench_Lite_for_ARM_EABI/bin
PATH=$PATH:$HOME/bin/openOCD
PATH=$PATH:$HOME/bin/openOCD/bin
export PATH

export CPPUTEST_HOME=$HOME/cppuTest

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM="xterm-256color"
else
    export TERM="xterm-color"
fi

source ~/.git-completion.sh

PS1='[\h \W]\[\e[32m\]$(__git_ps1 "(%s)")\[\e[0m\]\$ '

# User specific aliases and functions

alias q='exit'
alias ipconfig='/sbin/ifconfig'
alias gdiff='git difftool'
alias gitstatus='git status -uno'
alias less='less -CR'
alias vi='vim'
alias make='~/bin/make $*'
alias mntusb='/media/L3DT4000/linux/linux32/dt4000_login'
alias k60openocd='sudo openocd -s /usr/local/share/openocd/scripts -f interface/osbdm.cfg -f board/twr-k60n512.cfg'

function gshow() {
    git show $* | vi - "+set ft=c"
}

stty stop ''
stty start ''
stty -ixon
stty -ixoff
