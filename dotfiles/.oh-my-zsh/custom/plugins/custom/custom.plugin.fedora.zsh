# alias essentials:
alias q="exit"
alias y="yum"
alias sy="sudo yum"
alias u="sudo yum upgrade"
alias c="clear"
alias gitc="git commit -av ; git push -u origin master"


# alias system clean:
#alias clean='sudo emerge --depclean && sudo revdep-rebuild'
alias bb="sudo bleachbit --delete system.cache system.localizations system.trash system.tmp"


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
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'       # 'rm -i' prompts for every file
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'


