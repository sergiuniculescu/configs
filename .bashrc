#
# ~/.bashrc
#


# default editor
export EDITOR=vim
export VISUAL=vim


# completion:
set show-all-if-ambiguous on
complete -cf sudo
complete -cf man


# find packages commands:
##################
#!/bin/bash
command_not_found_handle () {
        local command="$1"
        local pkgs="$(pkgfile -b -v -- "$command")"
        if [ ! -z "$pkgs" ]; then
                echo -e "\n$command may be found in the following packages:\n$pkgs"
                return 0
        fi
        printf "bash: $(gettext bash "%s: command not found")\n" $command >&2
        return 127
}
#################


# make multiple shells share the same history file:
shopt -s histappend
export PROMPT_COMMAND="history -a ; ${PROMPT_COMMAND:-:}"
export HISTCONTROL=erasedups
export HISTSIZE=10000


# alias essentials:
alias e=exit
alias p=pacman-color
alias sp="sudo pacman-color"
alias y=yaourt
alias u="sudo pacman-color -Syu"
alias uy="yaourt -Sya"
alias c="clear"
alias mc="mc -S dark.ini"
alias gitc="git commit -av ; git push -u origin master"


# alias system clean:
alias clean="yaourt -Qdt; sudo pacman -Sc && sudo pacman-optimize"
alias bb="sudo bleachbit --clean system.cache system.localizations system.trash system.tmp"
alias cc="sudo cacheclean 2"


# colorize commands:
alias ls='ls --color=auto'
alias ll="ls -lh --color=auto"
alias la="ls -la --color=auto"
alias grep="grep --color=auto"
alias zgrep="zgrep --color=auto"


# others alias:
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"
alias today='date "+%A, %B %d, %Y [%T]"'
alias du="du -c -h"


# network alias:
alias openports='netstat --all --numeric --programs --inet --inet6'
alias nets="sudo netstat -nlpt"
alias nets2="sudo lsof -i"


# safety features:
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'                    # 'rm -i' prompts for every file
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'



# Scripturi locale:
export PATH=$PATH:~/.bin/


#Add archey:
archey3


# Start X:
#####################
if [[ -z $DISPLAY && ! -e /tmp/.X11-unix/X0 ]] && (( EUID )); then
	while true; do
		read -p 'Start X? (y/n): '
		case $REPLY in
			[Yy]) exec xinit /usr/bin/ck-launch-session dbus-launch --exit-with-session startxfce4 ;;
			[nn]) break ;;
			*) printf '%s\n' 'Answer y or n. ' ;;
		esac
	done
fi
####################


# ps1:
# default is: PS1='[\u@\h \W]\$ '


# If not running interactively, don't do anything
#[[ $- != *i* ]] && return

