## Functions ##
###############

function tempsscert(){

    openssl req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out cert.pem $@
}

function add_to_path() {
    [ -z "$1" ] && return 1
    local path="$1"
    local paths p
    IFS=':' read -ra paths <<< $PATH
    for p in "${paths[@]}"; do
        # [ $path == $p ] && echo "Path '$p' alredy present" && return
        [ $path == $p ] && return
    done

    if [ -n "$2" ] && [ $2 == 'prepend' ]; then
        # echo "Prepending '$path' to \$PATH"
        export PATH="${path}:${PATH}"
    else
        # echo "Appending '$path' to \$PATH"
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
