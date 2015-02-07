#! /bin/bash
# bash related configuration

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# yaourt keeps asking me about this
export EDITOR="vim"

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command return and,
# if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# history file
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=30000
export HISTFILESIZE=60000

# bash completion
if [ -f /etc/bash_completion ]; then
   . /etc/bash_completion
fi

# bash completion for sudoers
complete -cf sudo

# format BOLD,...;FGColor[;BGColor]m
#        0-3?    ;30-36   ;40-47
__PS1pathBlue__="\[\033[01;34m"
__PS1retHl__="\[\033[00;00;41m"
__PS1ret__="\[\033[01;30m"
__PS1RST__="\[\033[00m"
case ${EUID} in
  0 ) # root
    PS1col='\[\033[01;31m' ;;
  1000 ) # me
    PS1col='\[\033[01;32m' ;;
  *) # others
    PS1col='\[\033[01;33m'
esac

PS1="\n$__PS1ret__\]\$? \$([[ \$? != 0 ]] && echo \"$__PS1retHl__\]\")$PS1col\]\u@\h:$__PS1pathBlue__\]\w$__PS1RST__\]\$ "

# enable colors for some things
eval "`dircolors -b`"
alias ls='$(which ls) -lah --color=always'

alias dir='$(which dir) --color=always'
alias vdir='$(which vdir) --color=always'

alias grep='$(which egrep) --color=always'
alias fgrep='$(which fgrep) --color=always'
alias egrep='$(which egrep) --color=always'

alias dmesg='$(which dmesg) -e --color=always'

alias less='$(which less) -r'

# dig with clearer output
alias digall='$(which dig) +all ANY'
alias dig='$(which dig) +short'

# check conn
alias _dig='$(which watch) "dig +short google.com; sleep 1; killall dig"'
#alias _curl='$(which curl) http://speedtest.qsc.de/10GB.qsc > /dev/null'
alias _curl='$(which curl) http://speedtest.wdc01.softlayer.com/downloads/test10.zip > /dev/null'


# some more aliases
alias ll='$(which ls) --color=always -Fh'
alias lf='$(which ls) --color=always -d */'
alias la='$(which ls) --color=always -Ah'
alias l='$(which ls) --color=always -CF'
alias ..='cd ..' # cd is a shell builtin, dummy!
alias ...='cd ../..'
alias ....='cd ../../..'
alias res='$(which reset)'
alias pstree='$(which pstree) -pUl'

# make aliases work with sudo?
alias sudo='$(which sudo) '

# more useful ps
alias ps='$(which ps) -eo pid,cmd'

# more useful netstat
alias netstat='$(which netstat) -anlWp'

# more useful jobs
alias jobs='jobs -l'

# human readable
alias df='$(which df) -h'

# human readable
alias free='$(which  free) -h'

# more info like fs, etc.
alias lsblk='$(which lsblk) -af'

# more useful socket info
alias ss='$(which ss) -raepi'

# iftop for my interfaces
alias _iftop='sudo $(which iftop) -i '

# better when immediately read by players
alias youtube-dl='youtube-dl --no-part'
