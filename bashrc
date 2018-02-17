# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


# User specific aliases and functions


# Functions #
#############

function getColorEsc(){
    declare -A fg
    declare -A bg
    fg["black"]=30;   bg["black"]=40
    fg["red"]=31;     bg["red"]=41
    fg["green"]=32;   bg["green"]=42
    fg["yellow"]=33;  bg["yellow"]=43
    fg["blue"]=34;    bg["blue"]=44
    fg["magenta"]=35; bg["magenta"]=45
    fg["cyan"]=36;    bg["cyan"]=46
    fg["white"]=37;   bg["white"]=47

    local OPTIND; local OPTARG
    while getopts :f:b:osiul opt; do
        case $opt in
            f) local fgcname=$OPTARG ;;
            b) local bgcname=$OPTARG ;;
            o) local bold='true' ;; #Bold
            s) local sil='true' ;; #Shade/Silent
            i) local italic='true' ;; #Italic
            u) local underline='true' ;; # Underline
            l) local highlight='true' ;; #Highlight
            \?) echo "Uknown option -$OPTARG" >&2 ; return 1 ;;
            :) echo "Option -$OPTARG requires argument" >&2 ; return 1 ;;
        esac
    done

    local f_esc=''; local b_esc=''; local color_esc=''

    if [ ! -z $fgcname ]; then
        local fvname="fg[$fgcname]"
        [ -z ${!fvname} ] && echo "Unknown fg color" 1>&2 && return 2
        f_esc='\E['${!fvname}'m'
    fi
    if [ ! -z $bgcname ]; then
        local bvname="bg[$bgcname]"
        [ -z ${!bvname} ] && echo "Unknown bg color" 1>&2 && return 2
        b_esc='\E['${!bvname}'m'
    fi

    #Options
    local options=''
    [ "$bold" == 'true' ] && options+='\E[1m'
    [ "$sil" == 'true' ] && options+='\E[2m'
    [ "$italic" == 'true' ] && options+='\E[3m'
    [ "$underline" == 'true' ] && options+='\E[4m'
    [ "$highlight" == 'true' ] && options+='\E[7m'

    color_esc="${f_esc}${b_esc}${options}"

    [ ! -z "${color_esc}" ] && echo $color_esc || echo ''
    return 0
}

function color_echo(){

    local OPTIND; local OPTARG; local options=''
    while getopts :f:b:osiulm: opt; do
        case $opt in
            f) local fgcname=$OPTARG ;;
            b) local bgcname=$OPTARG ;;
            [osiul])
                opindex=$(( $OPTIND - 1 ))
                options="$options ${!opindex}"
                ;;
            m) local msg="$OPTARG" ;;
            \?) echo "Uknown option -$OPTARG" >&2 ; return 1 ;;
            :)  echo "Option -$OPTARG requires argument" >&2 ; return 1 ;;
        esac
    done

    [ -z "$msg" ] && echo "Requies text" >&2 && return 2

    local farg=${fgcname:+"-f $fgcname"}
    local barg=${bgcname:+"-b $bgcname"}

    local esc=$(getColorEsc $farg $barg $options)

    echo -e "${esc}${msg}\E[0m"

    return 0
}

#load python venv based on dir name
function venv(){

    [ -z "$PYENVS" ] &&
        color_echo -f red -o -m "No Virtualenv path defined" >&2 && return 3
    local create
    local OPTIND; local OPTARG
    while getopts ":chli:" opt; do
        case $opt in
        h)
            cat <<EOU

    Usage: $FUNCNAME [OPTIONS] <virtualenv>
        -h : Display help and exit
        -c : Create venv if it doesn't exist
        -l : List venvs and exit
        -i : Tries to install comma-separated items on venv with 'pip'

    Example: PYENVS=~/pyenvs venv -c -i pkg1,pkg2 envname

EOU
            return 0 ;;
        c) create='yes' ;;
        l)
            for e in $(ls -d $PYENVS/*); do
                echo $(basename $e)
            done
            return 0
            ;;
        i)
            local install_list=($(echo $OPTARG | sed 's/,/ /g'))
            ;;
        \?) echo "Invalid option: -$OPTARG" >&2 ; return 1 ;;
        :)echo "Option -$OPTARG requires an argument." >&2 ; return 1 ;;
        esac
    done
    shift $((OPTIND - 1))

    local venvbin
    if which virtualenv &>/dev/null; then
        venvbin='virtualenv'
    elif which virtualenv-3 &>/dev/null; then
        venvbin='virtualenv-3'
    else
        echo "Virtualenv not installed" >&2
        return 1
    fi


    [ -z "$1" ] && color_echo -f red -o -m "Specify venv dir" >&2 && return 1
    local vdir="${PYENVS}/$1"
    if [ "$create" == 'yes' ] ; then
        if [ -d $vdir ]; then
            color_echo -f blue -o -m "Virtualenv '$1' already exists" >&2
        else
            color_echo -f green -o -m "Creating '$1' virtualenv" >&2
            $venvbin $vdir
        fi
    fi

    if [ -d $vdir ]; then
        color_echo -f green -o -m "Sourcing '$1' virtualenv" >&2
        source $vdir/bin/activate
        echo "packages: ${install_list[@]} n: ${#install_list[@]}"
        if [[ $(which python) =~ $PYENVS ]] && [ ${#install_list[@]} -gt 0 ]; then
            color_echo -f green -o -m "Installing packages ${install_list[*]}"
            pip install ${install_list[@]}
        fi
    else
        color_echo -f red -o -m "Virtualenv '$1' does not exist" >&2
    fi

}

function tempsscert(){

    openssl req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out cert.pem $@
}

#start tune
#play -q "|sox -n -p synth 0.13 sin 200 delay 0.5" "|sox -n -p synth 0.13 sin 250" "|sox -n -p synth 0.13 sin 300" "|sox -n -p synth 0.13 sin 400" "|sox -n -p synth 0.13 sin 300" "|sox -n -p synth 0.13 sin 250" "|sox -n -p synth 0.4 sin 200" &
 
#use when failed command
#err_tune = $(play -q "|sox -n -p synth 0.2 sin 250 delay 0.5" "|sox -n -p synth 0.2 sin 240" "|sox -n -p synth 0.7 sin 220")

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

# Environmental variables #
###########################
# export PS1="\n\[$(tput sgr0)\]\[\033[38;5;2;1m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;3m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;6m\]\W\[$(tput sgr0)\]\[\033[38;5;15m\] \$? \`parse_git_branch\`\n\\$ \[$(tput sgr0)\]"
export PS1="\n\[$(tput sgr0)\]\[\e[38;2;175;175;0;1m\]\u \[$(tput sgr0)\]\[\e[38;1m\]@\[$(tput sgr0)\]\[\033[38;2;206;113;9;1m\] \h\[$(tput sgr0)\]\[\033[38;5;15m\] :\[$(tput sgr0)\]\[\033[38;2;135;175;175;1m\] \W\[$(tput sgr0)\]\[\033[38;5;15m\] \$? \`parse_git_branch\`\n\\$ \[$(tput sgr0)\]"
# Background: #262626
export EDITOR="vim"

# Golang env
if [ -z "$GOPATH" ]; then
    export GOPATH="${HOME}/devel/golang"
    mkdir -p $GOPATH
fi

# Golang bin path
if ! grep "${GOPATH}/bin" <(echo $PATH) &>/dev/null; then
    export PATH="${PATH}:${GOPATH}/bin"
fi

# My Scripts
if ! grep "${HOME}/bin" <(echo $PATH) &>/dev/null; then
    export PATH="${HOME}/bin:${PATH}"
fi





DKPSFMT="\n\n\tName\t{{.Names}}\n\tID\t{{.ID}}\n\tImage\t{{.Image}}\n\tStatus\t{{.Status}}\n\tPorts\t{{.Ports}}\n\tCommand\t{{.Command}}"

export PYENVS="${HOME}/devel/python/Environments"


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

alias sbrc='source ~/.bashrc'


alias mypubip='dig +short myip.opendns.com @resolver1.opendns.com'

# X Settings
##############
# If on X and DE or WM doesn't easily support keyboard layout switch
# setxkbmap -model logitech_g15 -layout us,br -variant ,abnt2 -option grp:alt_shift_toggle


PATH="/home/lblotta/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/lblotta/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/lblotta/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/lblotta/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/lblotta/perl5"; export PERL_MM_OPT;
