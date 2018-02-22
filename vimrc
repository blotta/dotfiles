" Settings {{{

" EDITING FUNCTIONALITY
" no vi-compatible
set nocompatible

"tabs
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" search
set incsearch " incremental
" set hlsearch " highlight search
set ignorecase " ignore case on search
set smartcase " when ignorecase is on, match case if search contains uppercase

" no backup and .swp files
set nobackup
set nowritebackup
set noswapfile

" comm history
set history=100

" raise error when quitting while unsaved buffers exist?
set hidden

" no word wrap
" set nowrap

" allow backspace to delete eol, indent and start of line chars
" set backspace=indent,eol,start

" no delay when pressing O (O as in oil)
set timeout timeoutlen=1000 ttimeoutlen=50

" encoding
set encoding=utf-8

" Autoload to load files changed outside vim
set autoread

" use system clipboard (may need to compile vim with clipboard flag)
set clipboard+=unnamed

" Enable mouse support in all modes. Helps with vim within Tmux
set mouse=a

" Visual Settings
" syntax highlight on
syntax on

" status bar
set laststatus=2 " always on
set statusline=%f\ %=L:%l/%L\ %c\ (%p%%)

" line numbers
set nu

" " show trailing hidden chars
set list listchars=tab:\ \ ,trail:·

" Don't show intro
set shortmess+=I

" new windows below and to the right
set splitbelow
set splitright

" no beep on mistype
set visualbell

" visual autocomplete for command menu
" set wildmenu

" highlight column 80
autocmd BufWinEnter * highlight ColorColumn ctermbg=black
set colorcolumn=81

" built-in file explorer
" let g:netrw_liststyle=3     " tree view
" let g:netrw_banner=0        " disable annoying banner
" let g:netrw_browse_split=4  " open in prior window (?)
" let g:netrw_altv=1          " open splits to the right
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'


" }}}

" Test from YT video {{{

" " enable syntax and plugins (builtin netrw)
" syntax enable
" filetype plugin on

" " search recursively
" set path+=**
" " ':find (<regex>|<file>|<path>)'

" " create tags file
" command! Maketags !ctags -R .
" " ^]    jump to tag under cursor
" " g^]   for umbiguous tags
" " ^t    jump back up the tag stack

" " autocomplete (look for |ins-completion|
" " ^x^n  just current file
" " ^x^f  filenames
" " ^x^]  tags only
" " ^n    anything specified by the 'complete' option

" }}}

" Plugins {{{

" Plugin manager {{{
" https://github.com/tpope/vim-pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on
" }}}

" vim-commentary {{{
" https://github.com/tpope/vim-commentary
" add filetype comment
" autocmd FileType apache setlocal commentstring=#\ %s
" }}}

" NERDTree {{{
if filereadable(expand("$HOME/.vim/bundle/nerdtree/plugin/NERD_tree.vim"))
    " https://github.com/scrooloose/nerdtree
    " map to ctrl+n
    map <C-n> :NERDTreeToggle<CR>
    " close vim if NERDTree is only window open
    " autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && \
    " b:NERDTree.isTabTree()) | q | endif
    " Open NERDTree when vim opens (with argument)
    " autocmd vimenter * NERDTree
endif
" }}}

" vim-surround {{{
" https://github.com/tpope/vim-surround
" }}}

" YouCompleteMe {{{
" https://github.com/Valloric/YouCompleteMe#fedora-linux-x64
" ensures to close autocomplete windows when done
" let g:ycm_autoclose_preview_window_after_completion=1
" goto shortcut
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" If ycm used python2
let g:ycm_server_python_interpreter = 'python2'

" Make YCM aware of virtualenv
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
" }}}

" Syntastic {{{
" https://github.com/vim-syntastic/syntastic

" Recommended start config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['flake8']
" }}}

" }}}

" Theme {{{
if filereadable(expand("$HOME/.vim/bundle/gruvbox/colors/gruvbox.vim"))
    colorscheme gruvbox
else
    colorscheme desert
endif
set background=dark
if g:colors_name == 'gruvbox'
    let g:gruvbox_contrast_dark = 'soft'
endif
" }}}

" Mappings {{{

"Standard system Ctrl-c Ctrl-v (needs to be compiled with clipboard)
" Copy
vmap <C-c> "+y
"Paste
imap <C-v> <C-r>+

" Save file with F2
nmap <F2> :w<Cr>
imap <F2> <ESC>:w<CR>i

" Try to execute current file
nnoremap <F9> :!%:p<ENTER>
inoremap <F9> <ESC>:!%:p<ENTER>

" tab nav
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm 
map tt :tabnew 
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>

" Keep forgetting I'm on Insert mode
inoremap <C-w> <ESC><C-w>

" }}}

" Commands {{{

" When editing vimrc {{{
" reading
autocmd! BufReadPost .vimrc
    \ setlocal foldmethod=marker

"writing
autocmd! BufWritePost .vimrc
    \ source ~/.vimrc
    \ | echo "Configuration Reloaded"
" }}}

" PEP8 indentention when python {{{
autocmd BufNewFile,BufRead *.py
    \ setlocal tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=79
    \ expandtab
    \ autoindent
    \ fileformat=unix
" }}}

" for full stack dev {{{
autocmd BufNewFile,BufRead *.{js,html,css}
    \ setlocal tabstop=2
    \ softtabstop=2
    \ shiftwidth=2
" }}}

" C programming {{{
autocmd BufNewFile,BufRead *.{c,cpp,h}
    \ setlocal tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ noexpandtab
autocmd BufWrite *.c :echom "Writing C file"
"}
" }}}

" Markdown {{{
autocmd! BufRead,BufNewFile *.{markdown,md}
    \ setlocal filetype=markdown
    \ cc=

" }}}
" }}}
