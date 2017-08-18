#!/bin/bash

# Do not run as root
[ $UID -eq 0 ] && echo "Should not be run as root" >&2 && exit 1


# Place rc files
DOTFILEPATH=$(dirname $(realpath $0))

for c in 'bashrc' 'vimrc' 'tmux.conf'; do
    [ -L ~/.${c} ] && unlink ~/.${c}
    [ -f ~/.${c} ] && mv ~/.${c} ~/.${c}.bak

    ln -s $DOTFILEPATH/${c} ~/.${c}
done

# To continue, check internet connection
if ! timeout 3 bash -c "</dev/tcp/8.8.8.8/53" &>/dev/null; then
    echo "No internet connectivity. Can't continue." >&2
    exit 0
fi

# Check vim dependencies

vim_plugins=( 'nerdtree' 'syntastic' 'vim-commentary' 'vim-surround' 'YouCompleteMe')

vim_themes=('zenburn')

declare -A plugin_clone
plugin_clone["nerdtree"]='https://github.com/scrooloose/nerdtree.git'
plugin_clone["syntastic"]='--depth=1 https://github.com/vim-syntastic/syntastic.git'
plugin_clone["vim-commentary"]='git://github.com/tpope/vim-commentary.git'
plugin_clone["vim-surround"]='git://github.com/tpope/vim-surround.git'
plugin_clone["YouCompleteMe"]='https://github.com/Valloric/YouCompleteMe.git'


mkdir -p $HOME/.vim/{autoload,bundle,colors}

# Pathogen
if [ ! -f $HOME/.vim/autoload/pathogen.vim ]; then
    # Install pathogen
    curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

# Plugins
cd $HOME/.vim/bundle

