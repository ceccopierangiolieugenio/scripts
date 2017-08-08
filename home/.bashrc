# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

. colors.source

__PTY="${Yellow}\l "
__USER="${Red}\u "
__HOST="${Green}\h "
__TIME="${Yellow}\A "
__PID="${Red}(\!) "
__PATH="${Cyan}\w"

PS1="${__PTY}${__USER}${__HOST}${__TIME}${__PID}${__PATH}${_RST_}\n \$ "

export EDITOR=vim

alias ll="ls -la --color"
alias grep="grep --color"

export HISTCONTROL=ignoredups
export PATH=~/usr/bin:$PATH

