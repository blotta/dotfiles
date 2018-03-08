" Plugs
call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
Plug 'Shougo/neco-vim'
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-go', { 'do' : 'make' }
Plug 'w0rp/ale'
" Plug 'roxma/nvim-completion-manager'
call plug#end()

" nvim settings {{{
set hidden
set number
set mouse=a
set inccommand=nosplit
set clipboard+=unnamedplus

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set incsearch
set ignorecase
set smartcase

set autoread

" " show trailing hidden chars
set list listchars=tab:\ \ ,trail:·

set laststatus=2
if !has('gui_running')
    set t_Co=256
endif

" set correct python interp
let g:python_host_prog = expand('$PYENV_ROOT/versions/neovim2/bin/python2')
let g:python3_host_prog = expand('$PYENV_ROOT/versions/neovim3/bin/python3')

"""""""""""""""""""""""""""""""""""""""""""""""""" }}}


" Plugin Config {{{

" Deoplete {{{
let g:deoplete#enable_at_startup = 1

" Deoplete Python
let g:deoplete#sources#jedi#show_docstring = 1
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""" }}}


" nvim mappings {{{
let mapleader="\<space>"

nnoremap <leader>ce :tabnew ~/.config/nvim/init.vim<cr>
nnoremap <leader>cr :source ~/.config/nvim/init.vim<cr>

" Save file with F2
nnoremap <F2> :w<Cr>
inoremap <F2> <ESC>:w<CR>a

" Try to execute current file
nnoremap <F9> :!%:p<ENTER>
inoremap <F9> <ESC>:!%:p<ENTER>

"""""""""""""""""""""""""""""""""""""""""""""""""" }}}


" Hooks {{{

" When editing vimrc {{{
" reading
autocmd! BufReadPost init.vim
    \ setlocal foldmethod=marker

"writing
autocmd! BufWritePost init.vim
    \ source ~/.config/nvim/init.vim
    \ | echo "Configuration Reloaded"
" }}}

" Web {{{
autocmd! BufNewFile,BufRead *.{js,html,css}
    \ setlocal tabstop=2
    \ softtabstop=2
    \ shiftwidth=2
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""" }}}


" modeline {{{

" Onyl if lightline is installed
set noshowmode
let g:lightline = {
    \ 'colorscheme':  'jellybeans',
    \ }

" }}}

" Theme {{{
set background=dark

colorscheme gruvbox

"""""""""""""""""""""""""""""""""""""""""""""""""" }}}
