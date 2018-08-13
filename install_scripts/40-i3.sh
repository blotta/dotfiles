#!/bin/bash

SCRIPT=$(basename -s .sh $0 )
FAKEHOME="$1"
I3PATH=$HOME/.config/i3

[ -z "$FAKEHOME" ] && echo "$SCRIPT: missing base home directory" && exit 1


# Main i3 config
mkdir -p $I3PATH

[ -L $I3PATH/config ] && unlink $I3PATH/config
[ -f $I3PATH/config ] && mv $I3PATH/config $I3PATH/config.$(date +%Y%m%d%H%M%S).bak

ln -s $FAKEHOME/config/i3/config $I3PATH/config



# i3blocks config
I3BLOCKSPATH=$HOME/.config/i3blocks

mkdir -p $I3BLOCKSPATH

[ -L $I3BLOCKSPATH/i3blocks.conf ] && unlink $I3BLOCKSPATH/i3blocks.conf
[ -f $I3BLOCKSPATH/i3blocks.conf ] && \
    mv $I3BLOCKSPATH/i3blocks.conf $I3BLOCKSPATH/i3blocks.conf.$(date +%Y%m%d%H%M%S).bak

ln -s $FAKEHOME/config/i3blocks/i3blocks.conf $I3BLOCKSPATH/i3blocks.conf




echo 'Install i3, i3blocks, rofi and compton (There may be more tools necessary for gathering info)' >&2
