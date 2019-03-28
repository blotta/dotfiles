# Environmental variables #
###########################

export TERM="xterm-256color"

export PS1="\n\[$(tput sgr0)\]$(tput setaf 178; tput bold)\u \[$(tput sgr0)\]$(tput bold)@\[$(tput sgr0)\]$(tput setaf 166; tput bold; tput dim) \h\[$(tput sgr0)\] :\[$(tput sgr0)\]$(tput setaf 61; tput bold; tput dim) \W\[$(tput sgr0)\] \$? \`parse_git_branch\`\n\\$ \[$(tput sgr0)\]"
# Background: #262626

export EDITOR="nvim"

export PAGER="less"

export DKPSFMT="\n\n\tName\t{{.Names}}\n\tID\t{{.ID}}\n\tImage\t{{.Image}}\n\tStatus\t{{.Status}}\n\tPorts\t{{.Ports}}\n\tCommand\t{{.Command}}"