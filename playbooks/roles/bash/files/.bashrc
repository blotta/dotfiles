# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi



# Environmental variables #
###########################

export TERM="xterm-256color"

export PS1="\n\[$(tput sgr0)\]$(tput setaf 178; tput bold)\u \[$(tput sgr0)\]$(tput bold)@\[$(tput sgr0)\]$(tput setaf 166; tput bold; tput dim) \h\[$(tput sgr0)\] :\[$(tput sgr0)\]$(tput setaf 61; tput bold; tput dim) \W\[$(tput sgr0)\] \$? \`parse_git_branch\`\n\\$ \[$(tput sgr0)\]"
# Background: #262626

export EDITOR="nvim"

export PAGER="less"

export DKPSFMT="\n\n\tName\t{{.Names}}\n\tID\t{{.ID}}\n\tImage\t{{.Image}}\n\tStatus\t{{.Status}}\n\tPorts\t{{.Ports}}\n\tCommand\t{{.Command}}"




# BASH OPTIONS

# Alt+h to go to man page of command previous to cursor
bind '"\eh": "\C-a\eb\ed\C-y\e#man \C-y\C-m\C-p\C-p\C-a\C-d\C-e"'

# Check window size after every command
shopt -s checkwinsize



## Functions ##
###############

function tempsscert(){

    openssl req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out cert.pem $@
}

function echo_paths() {
    local paths p
    IFS=':' read -ra paths <<< $PATH
    for p in "${paths[@]}"; do
        echo $p
    done
}

function add_to_path() {
    [ -z "$1" ] && return 1
    local path="$1"
    paths=($(echo_paths))
    for p in ${paths[@]}; do
        [ $path == $p ] && return
    done

    if [ -n "$2" ] && [ $2 == 'prepend' ]; then
        export PATH="${path}:${PATH}"
    else
        export PATH="${PATH}:${path}"
    fi
}

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

# prints vertical split division
function tdivstr(){
    dc=${1:-'='}
    #[ ${#dc} -eq 1 ] && col=1 ||
    cols=$(( $(tput cols) / ${#dc} ))
    printf "${dc}%.0s" $(seq 1 $cols)
}

function simple_ipa(){
    local ifs=($(ip a | perl -ne 'print qq{ $1 } if /^\d{1,2}:\s([a-z-0-9]+):/;'))
    for i in ${ifs[@]}; do
        echo
        echo $i
        ip a s $i | perl -ne 'print qq{  $1: $2\n} if /^\s+(inet6?)\s(\S+)\s/'
    done
    echo
    # ip a | perl -ne 'print qq{\n$1\n} if /^\d:\s([a-z-0-9]+):/; print qq{  $1: $2\n} if /^\s+(inet6?)\s(\S+)\s/'
}



## Aliases ##
#############

alias dnfu='sudo dnf update'
alias dnfi='sudo dnf install'
alias dnfs='dnf search'

alias doihave='rpm -qa | grep'

alias ls='ls --color'
alias ll='ls -l'
alias la='ls -a'
alias lla='ll -a'

alias cdtmp='cd $(mktemp -d)'
alias cdold='cd $OLDPWD'

alias dkps='docker ps'
alias dkpsa='dkps -a'
alias dkpsaq='dkpsa -q'
alias dkpsfmt="dkps --format=\"$(echo $DKPSFMT|sed 's/^/`tdivstr`/')\" ; tdivstr _"
alias dkpsafmt="dkpsa --format=\"$(echo $DKPSFMT|sed 's/^/`tdivstr _`/')\" ; tdivstr _"
alias dkrd='docker rmi $(docker images -q -f dangling=true) 2>/dev/null'

alias dkvl='docker volume ls'
alias dkvlq='dkvl -q'
alias dkvr='docker volume rm'
alias dkvi='docker volume inspect'

alias dki='docker inspect'

alias dkn='docker network'
alias dkni='dkn inspect'
alias dknr='dkn rm'
alias dknl='dkn ls'

alias dkcmp='docker-compose'
alias dkcmpb='docker-compose build'
alias dkcmpup='docker-compose up'

alias jj='journalctl'

alias SS='systemctl'
alias SSs='systemctl status'
alias SSa='sudo systemctl start'
alias SSo='sudo systemctl stop'
alias SSr='sudo systemctl restart'

alias G='git status'
alias Gd='git diff'
alias Gtop='git status &>/dev/null && while [ ! -d .git ]; do cd .. ; done '
alias Gc='git commit -m '

alias sbrc='source ~/.bashrc'

alias ipa='simple_ipa'

alias mypubip='dig +short myip.opendns.com @resolver1.opendns.com'

alias lblk='lsblk -o NAME,LABEL,FSTYPE,MOUNTPOINT,FSSIZE,FSUSED,ROTA'



# Golang env
[ -z "$GOPATH" ] && \
    GOPATH="${HOME}/go" && \
    mkdir -p $GOPATH

# Golang bin path
[ -n "$GOPATH" ] && add_to_path "${GOPATH}/bin" prepend

# Node.js
[ -d "$HOME/.node_modules_global" ] && add_to_path "$HOME/.node_modules_global/bin" prepend

# My Scripts
mkdir -p ${HOME}/bin && add_to_path "${HOME}/bin" prepend
mkdir -p ${HOME}/.local/bin && add_to_path "${HOME}/.local/bin" prepend