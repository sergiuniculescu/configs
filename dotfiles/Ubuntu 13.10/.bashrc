# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#############
### Alias ###
#############

# ls shortcuts
alias ls='ls --sort=extension --color=auto'
alias ll='ls -lh --color=auto'
alias lla='ls -alh --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias lz='ls -Z --color=auto'
alias lst="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"
alias lsp="ls -lah | awk '{k=0;s=0;for(i=0;i<=8;i++){;k+=((substr(\$1,i+2,1)~/[rwxst]/)*2^(8-i));};j=4;for(i=4;i<=10;i+=3){;s+=((substr(\$1,i,1)~/[stST]/)*j);j/=2;};if(k){;printf(\"%0o%0o \",s,k);};print;}'"

# Cute shell shortcuts
alias psg='ps -A | grep'
alias sv='sudo vim'
alias v='vim'
alias grep='grep --color -n'
alias e='exit'
alias c='clear'
alias today='date "+%A, %B %d, %Y [%T]"'
alias lds="du -hsx * | sort -rh"
alias mac="ifconfig -a| grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'"

# Some more, to avoid mistakes
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Git Commands
alias gitc="git commit -av ; git push -u origin master"

# YUM #
alias ai='sudo apt-get install'
alias ar='sudo apt-get purge'
alias as='sudo apt-cache search'
alias ap='sudo apt-cache policy'
alias ac='sudo apt-get autoclean & sudo apt-get autoremove'
alias au='sudo apt-get update & sudo apt-get upgrade'

##############
### Prompt ###
##############

### Colors ###
# Regular #
export black="\[\033[0;38;5;0m\]"
export red="\[\033[0;38;5;1m\]"
export orange="\[\033[0;38;5;130m\]"
export green="\[\033[0;38;5;2m\]"
export yellow="\[\033[0;38;5;3m\]"
export blue="\[\033[0;38;5;4m\]"
export bblue="\[\033[0;38;5;12m\]"
export magenta="\[\033[0;38;5;55m\]"
export cyan="\[\033[0;38;5;6m\]"
export white="\[\033[0;38;5;7m\]"
export coldblue="\[\033[0;38;5;33m\]"
export smoothblue="\[\033[0;38;5;111m\]"
export iceblue="\[\033[0;38;5;45m\]"
export turqoise="\[\033[0;38;5;50m\]"
export smoothgreen="\[\033[0;38;5;42m\]"
# Bold #
export bblack="\[\033[1;38;5;0m\]"
export bred="\[\033[1;38;5;1m\]"
export borange="\[\033[1;38;5;130m\]"
export bgreen="\[\033[1;38;5;2m\]"
export byellow="\[\033[1;38;5;3m\]"
export bblue="\[\033[1;38;5;4m\]"
export bbblue="\[\033[1;38;5;12m\]"
export bmagenta="\[\033[1;38;5;55m\]"
export bcyan="\[\033[1;38;5;6m\]"
export bwhite="\[\033[1;38;5;7m\]"
export bcoldblue="\[\033[1;38;5;33m\]"
export bsmoothblue="\[\033[1;38;5;111m\]"
export biceblue="\[\033[1;38;5;45m\]"
export bturqoise="\[\033[1;38;5;50m\]"
export bsmoothgreen="\[\033[1;38;5;42m\]"

function pre_prompt {
        newPWD="${PWD}"
        user="sergiu"
        host=$(echo -n $HOSTNAME | sed -e "s/[\.].*//")
        datenow=$(date "+%a, %d %b %y")
        let promptsize=$(echo -n "┌(${PWD})($user@$host ddd., DD mmm YY)┐" \
                | wc -c | tr -d " ")
        let fillsize=${COLUMNS}-${promptsize}
        fill=""
        while [ "$fillsize" -gt "0" ] 
            do 
                fill="${fill}─"
                    let fillsize=${fillsize}-1
                    done
                    if [ "$fillsize" -lt "0" ]
                        then
                            let cutt=3-${fillsize}
            newPWD="...$(echo -n $PWD | sed -e "s/\(^.\{$cutt\}\)\(.*\)/\2/")"
                fi

}

PROMPT_COMMAND=pre_prompt

case "$TERM" in
xterm)
## Original ##    PS1="$bblue┌─($orange\u@\h \$(date \"+%a, %d %b %y\")$bblue)─\${fill}─($orange\$newPWD\
# $bblue)─┐\n$bblue└─($orange\$(date \"+%H:%M\") \$$bblue)─>$white "
    PS1="$coldblue┌─($bwhite\u $white@$bwhite Ubuntu 13.10 $white- $byellow\$(date \"+%a, %d %b %y\")$coldblue)─($bcyan\$newPWD\
$coldblue)─┐\n$coldblue└─($byellow\$(date \"+%H:%M\")$bwhite \$$coldblue)─>$white "
    ;;
screen)
    PS1="$coldblue┌─($bwhite\u $white@$bwhite Ubuntu 13.10 $white- $byellow\$(date \"+%a, %d %b %y\")$coldblue)─($bcyan\$newPWD\
$coldblue)─┐\n$coldblue└─($byellow\$(date \"+%H:%M\")$bwhite \$$coldblue)─>$white "
    ;;    
    *)
    PS1="┌─(\u@\h \$(date \"+%a, %d %b %y\"))─(\$newPWD\
)─┐\n└─(\$(date \"+%H:%M\") \$)─> "
    ;;
esac


# Determine what prompt to display:
# 1.  Display simple custom prompt for shell sessions started
#     by script.  
# 2.  Display "bland" prompt for shell sessions within emacs or 
#     xemacs.
# 3   Display promptcmd for all other cases.

function load_prompt () {
    # Get PIDs
    local parent_process=$(cat /proc/$PPID/cmdline | cut -d \. -f 1)
    local my_process=$(cat /proc/$$/cmdline | cut -d \. -f 1)

    if  [[ $parent_process == script* ]]; then
        PROMPT_COMMAND=""
        PS1="\t - \# - \u@\H { \w }\$ "
    elif [[ $parent_process == vim* || $parent_process == emacs* ]]; then
        PROMPT_COMMAND=""
        PS1="\u@\h { \w }\$ "
    else
        export DAY=$(date +%A)
        PROMPT_COMMAND=pre_prompt
     fi 
    export PS1 PROMPT_COMMAND
}

load_prompt
