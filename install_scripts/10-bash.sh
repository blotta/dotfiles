#!/bin/bash

echo "Doing bash"

SCRIPT=$(basename -s .sh $0 )
FAKEHOME="$1"
[ -z "$FAKEHOME" ] && echo "$SCRIPT: missing base home directory" && exit 1

[ -L ~/.bashrc ] && unlink ~/.bashrc
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.$(date +%Y%m%d%H%M%S).bak

ln -s $FAKEHOME/bashrc ~/.bashrc
