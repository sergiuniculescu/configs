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


