# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

#############
### Alias ###
#############

# Cute shell shortcuts
alias ls='ls --sort=extension --color=auto'
alias ll='ls -lh --color=auto'
alias lla='ls -alh --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias lz='ls -Z --color=auto'
alias psg='ps -A | grep'
alias sv='sudo vim'
alias v='vim'
alias grep='grep --color -n'
alias e='exit'
alias c='clear'

# Some more, to avoid mistakes
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Git Commands
alias gitc="git commit -av ; git push -u origin master"

# YUM #
alias yi='sudo yum install'
alias yr='sudo yum remove'
alias yrr='sudo yum remove --remove-leaves'
alias ys='yum search'
alias ysa='sudo yum search all'
alias yca='sudo yum clean all'
alias yu='sudo yum update'


####################
### Bash history ###
####################

# Make multiple shells share the same history file
HISTSIZE=50000
HISTFILESIZE=50000
export PROMPT_COMMAND="history -a ; ${PROMPT_COMMAND:-:}"

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
export HISTIGNORE='&:clear:ls:cd:[bf]g:exit:[ t\]*'
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

## some shopt options ##
# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# correct minor spelling errors in cd
shopt -s cdspell
#include dotfiles in wildcard expansion, and match case-insensitively
shopt -s dotglob
shopt -s nocaseglob


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
    PS1="$coldblue┌─($bwhite\u $white@$bwhite CentOS release 6.4 $white- $byellow\$(date \"+%a, %d %b %y\")$coldblue)─($bcyan\$newPWD\
$coldblue)─┐\n$coldblue└─($byellow\$(date \"+%H:%M\")$bwhite \$$coldblue)─>$white "
    ;;
screen)
    PS1="$coldblue┌─($bwhite\u $white@$bwhite CentOS release 6.4 $white- $byellow\$(date \"+%a, %d %b %y\")$coldblue)─($bcyan\$newPWD\
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
