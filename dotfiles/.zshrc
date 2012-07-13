# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="xiong-chiamiov"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/core_perl:/home/sergiu/.bin/


# language
export LANG=en_US.UTF-8


# default editor
export EDITOR=vim
export VISUAL=vim


# make multiple shells share the same history file:
#shopt -s histappend
#export PROMPT_COMMAND="history -a ; ${PROMPT_COMMAND:-:}"
#export HISTCONTROL=erasedups
#export HISTSIZE=10000


# alias essentials:
alias q=exit
alias p=pacman-color
alias sp="sudo pacman-color"
alias y=yaourt
alias u="sudo pacman-color -Syu"
alias uy="yaourt -Syua"
alias c="clear"
alias mc="mc -S dark.ini"
alias gitc="git commit -av ; git push -u origin master"


# alias system clean:
alias clean='sudo pacman -Sc && sudo pacman-optimize'
alias bb="sudo bleachbit --clean system.cache system.localizations system.trash system.tmp"
alias cc="sudo cacheclean -p 2"


# colorize commands:
alias ls="ls --color=auto"
alias ll="ls -lh --color=auto"
alias la="ls -la --color=auto"
alias grep="grep --color=auto"
alias zgrep="zgrep --color=auto"


# others alias:
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"
alias today='date "+%A, %B %d, %Y [%T]"'
alias du="du -hsx * | sort -rh"
alias n='stat -c "%A (%a) %8s %.19y %n" '


# network alias:
alias openports='netstat --all --numeric --programs --inet --inet6'
alias nets="sudo netstat -nlpt"
alias nets2="sudo lsof -i"
alias mac="ifconfig -a| grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'"


# safety features:
#alias cp='cp -i'
#alias mv='mv -i'
alias cp='acp -g -i'   # need 'advcp' package
alias mv='amv -g -i'   # need 'advcp' package
alias rm='rm -I'       # 'rm -i' prompts for every file
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'


# Directory size function:
dirsize ()
{
    du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
    egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
    egrep '^ *[0-9.]*M' /tmp/list
    egrep '^ *[0-9.]*G' /tmp/list
    rm -rf /tmp/list
}


# Add archey:
archey3

# start X:
###################
## with a prompt ##

#if [[ -z $DISPLAY && ! -e /tmp/.X11-unix/X0 ]] && (( EUID )); then
#  while true; do
#    read -p 'Start X? (y/n): '
#    case $REPLY in
#      [Yy]) exec startx ;;
#      [Nn]) break ;;
#      *) printf '%s\n' 'Answer y or n.' ;;
#    esac
#  done
#fi
#################

## autostart ##
if [[ -z $DISPLAY ]] && ! [[ -e /tmp/.X11-unix/X0 ]] && (( EUID )); then
      exec startx
fi
###############

umask 077

