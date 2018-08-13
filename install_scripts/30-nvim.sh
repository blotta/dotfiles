#!/bin/bash

echo "Doing neovim"

SCRIPT=$(basename -s .sh $0 )
FAKEHOME="$1"
NVIMPATH=$HOME/.config/nvim

[ -z "$FAKEHOME" ] && echo "$SCRIPT: missing base home directory" && exit 1

mkdir -p $NVIMPATH

[ -L $NVIMPATH/init.vim ] && unlink $NVIMPATH/init.vim
[ -f $NVIMPATH/init.vim ] && mv $NVIMPATH/init.vim $NVIMPATH/init.vim.$(date +%Y%m%d%H%M%S).bak

ln -s $FAKEHOME/config/nvim/init.vim $NVIMPATH/init.vim

