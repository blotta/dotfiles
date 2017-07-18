# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# Colors #
##########
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
            f)
                local fgcname=$OPTARG
                ;;
            b)
                local bgcname=$OPTARG
                ;;
            o)
                #Bold
                local bold='true'
                ;;
            s)
                #Shade/Silent
                local sil='true'
                ;;
            i)
                #italic
                local italic='true'
                ;;
            u)
                #Underline
                local underline='true'
                ;;
            l)
                #Highlight
                local highlight='true'
                ;;
            \?)
                echo "Uknown option -$OPTARG" >&2
                return 1
                ;;
            :)
                echo "Option -$OPTARG requires argument" >&2
                return 1
                ;;
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
    [ "$bold" == 'true' ] && options="$options"'\E[1m'
    [ "$sil" == 'true' ] && options="$options"'\E[2m'
    [ "$italic" == 'true' ] && options="$options"'\E[3m'
    [ "$underline" == 'true' ] && options="$options"'\E[4m'
    [ "$highlight" == 'true' ] && options="$options"'\E[7m'

    color_esc="${f_esc}${b_esc}${options}"

    [ ! -z "${color_esc}" ] && echo $color_esc || echo ''
    return 0
}

function color_echo(){

    local OPTIND; local OPTARG; local options=''
    while getopts :f:b:osiulm: opt; do
        case $opt in
            f)
                local fgcname=$OPTARG
                ;;
            b)
                local bgcname=$OPTARG
                ;;
            [osiul])
                opindex=$(( $OPTIND - 1 ))
                options="$options ${!opindex}"
                ;;
            m)
                local msg="$OPTARG"
                ;;
            \?)
                echo "Uknown option -$OPTARG" >&2
                return 1
                ;;
            :)
                echo "Option -$OPTARG requires argument" >&2
                return 1
                ;;
        esac
    done

    [ -z "$msg" ] && echo "Requies text" >&2 && return 2

    local farg=${fgcname:+"-f $fgcname"}
    local barg=${bgcname:+"-b $bgcname"}

    local esc=$(getColorEsc $farg $barg $options)

    echo -e "${esc}${msg}\E[0m"

    return 0
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
    printf "${dc}%.0s" $(seq 1 $COLUMNS)
}

export PS1="\n\[$(tput sgr0)\]\[\033[38;5;2m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;3m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;6m\]\W\[$(tput sgr0)\]\[\033[38;5;15m\] \$? \`parse_git_branch\`\n\\$ \[$(tput sgr0)\]"

function dkfmt(){
    
    DKPSFMT="$(tdivstr)\n\tName\t{{.Names}}\n\tID\t{{.ID}}\n\tImage\t{{.Image}}\n\tStatus\t{{.Status}}\n\tPorts\t{{.Ports}}\n\tCommand\t{{.Command}}"
    printf "%s" $DKPSFMT
}

## Aliases ##
#############

alias dnfu='sudo dnf update'
alias dnfi='sudo dnf install'
alias dnfs='dnf search'

alias la='ls -a'
alias lla='ll -a'

alias dkps='docker ps'
alias dkpsa='dkps -a'
alias dkpsaq='dkpsa -q'
alias dkpsfmt="dkps --format=\"$(dkfmt)\" ; tdivstr"
alias dkpsafmt="dkpsa --format=\"$(dkfmt)\" ; tdivstr"

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
alias SSstart='sudo systemctl start'
alias SSstop='sudo systemctl stop'
alias SSr='sudo systemctl restart'
