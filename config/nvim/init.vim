" Plugs
call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'roxma/nvim-completion-manager'
Plug 'roxma/python-support.nvim'
Plug 'roxma/ncm-clang'
Plug 'Shougo/neco-vim'
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

" " set correct python interp
" let g:python_host_prog = expand('$PYENV_ROOT/versions/neovim2/bin/python2')
" let g:python3_host_prog = expand('$PYENV_ROOT/versions/neovim3/bin/python3')

"""""""""""""""""""""""""""""""""""""""""""""""""" }}}


" Plugin Config {{{


" nvim-c-m settings
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Python support extra deps {{{

let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'flake8')
let g:python_support_python2_requirements = add(get(g:,'python_support_python2_requirements',[]),'flake8')

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

" When editing rc file {{{
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


" statusline {{{

" Onyl if lightline is installed
set noshowmode
let g:lightline = {
    \ 'colorscheme':  'jellybeans',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \           [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ }

" }}}


" Theme {{{
set background=dark

colorscheme gruvbox

"""""""""""""""""""""""""""""""""""""""""""""""""" }}}
