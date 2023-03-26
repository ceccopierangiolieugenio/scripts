. ~/.colors.source

__PTY="${Yellow}\l "
__USER="${Red}\u "
__HOST="${Green}\h "
__TIME="${Yellow}\A "
__PID="${Red}(\!) "
__PATH="${Cyan}\w"

PS1="${__PTY}${__USER}${__HOST}${__TIME}${__PID}${__PATH}${_RST_}\n \$ "

# Tmux DISPLAY variables update
if [ -n "$TMUX" ]; then
  function tup {
    export $(tmux show-environment | grep "^DISPLAY")
  }
fi

export EDITOR=vim

alias ll="ls -la --color"
alias lll='ls -rtla'
alias ppp='. ~/.venv.python/bin/activate'
alias grep="grep --color"

# get the name of last filename added/modified in the current dir
lll1(){ ls -rt1 | tail -n1 ;}

export GOPATH=~/github/go
export GOBIN=${GOPATH}/bin
export GOROOT=~/usr/go

export HISTCONTROL=ignoredups
export HISTTIMEFORMAT="%d/%m/%y %T "
export PATH=~/.local/bin/:~/usr/bin:${GOROOT}/bin:${GOBIN}:$PATH:$HOME/node/bin

# With the configuration below,
# I assume that all the local packages are
# installed inside ~/usr

export MANPATH=$MANPATH:~/usr/share/man
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:~/usr/lib/pkgconfig/

alias lib="LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/usr/lib/ "

# Emulate ag if missing
which ag >/dev/null 2>&1 ;
if [ $? == 1 ] ;
    then
        function ag {
          if [ -z $2 ] ;
            then FOLDER='.' ;
            else FOLDER=$2  ;
          fi ;
          grep $1 ${FOLDER} -r -n 2>/dev/null ;
        } ;
fi

