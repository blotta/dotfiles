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
alias dkcmpb='dkcmp build'
alias dkcmpup='dkcmp up'

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