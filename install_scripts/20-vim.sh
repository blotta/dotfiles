#!/bin/bash

echo "Doing vim"

SCRIPT=$(basename -s .sh $0 )
FAKEHOME="$1"
[ -z "$FAKEHOME" ] && echo "$SCRIPT: missing base home directory" && exit 1

[ -L ~/.vimrc ] && unlink ~/.vimrc
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.$(date +%Y%m%d%H%M%S).bak

ln -s $FAKEHOME/vimrc ~/.vimrc

mkdir -p $HOME/.vim
