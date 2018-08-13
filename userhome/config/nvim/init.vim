" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Plugs
call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-speeddating'
Plug 'kassio/neoterm'

" Visuals
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'

" NEW Completion
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'

Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-vim'
Plug 'ncm2/ncm2-go'

" Completion
"Plug 'w0rp/ale'
"Plug 'roxma/nvim-completion-manager'
"Plug 'roxma/python-support.nvim'
"Plug 'roxma/ncm-clang'
"Plug 'Shougo/neco-vim'

" rust
"Plug 'rust-lang/rust.vim'
"Plug 'racer-rust/vim-racer'
"Plug 'roxma/nvim-cm-racer'

"ruby
"Plug 'roxma/ncm-rct-complete'

" Text
Plug 'reedes/vim-pencil'
"Plug 'jceb/vim-orgmode'
call plug#end()

let mapleader="\<space>"

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

" netrw
let g:netrw_liststyle = 3

" " set correct python interp
" let g:python_host_prog = expand('$PYENV_ROOT/versions/neovim2/bin/python2')
" let g:python3_host_prog = expand('$PYENV_ROOT/versions/neovim3/bin/python3')

"""""""""""""""""""""""""""""""""""""""""""""""""" }}}


" Plugin Config {{{

" neoterm {{{

" Always scroll down to reveal latest output
let g:neoterm_autoscroll = '1'

let g:neoterm_size = 20

" Use gx{text-object} in normal mode
nmap gx <Plug>(neoterm-repl-send)

" Send selected contents in visual mode.
xmap gx <Plug>(neoterm-repl-send)

"use `gxx` or `2gxx` to send current or 2 lines to REPL.
nmap gxx <Plug>(neoterm-repl-send-line)

" hides terminal
nnoremap <leader>0 :Ttoggle<Enter>

" opens new term
nnoremap <leader>t :botright :Tnew<Enter> <C-w>j

" }}}

" ncm2 {{{
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
" IMPORTANTE: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" Optional
" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
        \ 'name' : 'css',
        \ 'priority': 9, 
        \ 'subscope_enable': 1,
        \ 'scope': ['css','scss'],
        \ 'mark': 'css',
        \ 'word_pattern': '[\w\-]+',
        \ 'complete_pattern': ':\s*',
        \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
        \ })

" }}}

" nvim-completion-manager settings {{{
" When popup shows and enter is pressed, hide menu and enter newline
"inoremap <expr> <CR> (pumvisible() ? '\<c-y>\<cr>' : '\<CR>')
"
"inoremap <expr> <Tab> pumvisible() ? '\<C-n>' : '\<Tab>'
"inoremap <expr> <S-Tab> pumvisible() ? '\<C-p>' : '\<S-Tab>'

" }}}

" Python support extra deps {{{
"
"let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'flake8')
"let g:python_support_python2_requirements = add(get(g:,'python_support_python2_requirements',[]),'flake8')
"
" }}}

" Rust racer {{{
"let g:racer_experimental_completer = 1
" }}}

" Ale {{{
"let g:ale_fixers = {
"            \'typescript': ['prettier'],
"            \}
" }}}

" Pencil {{{

let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""" }}}


" nvim mappings {{{

nnoremap <leader>ce :tabnew ~/.config/nvim/init.vim<cr>
nnoremap <leader>cr :source ~/.config/nvim/init.vim<cr>

" Save file with F2
nnoremap <F2> :w<Cr>
inoremap <F2> <ESC>:w<CR>a

" Try to execute current file
nnoremap <F9> :!%:p<ENTER>
inoremap <F9> <ESC>:!%:p<ENTER>

" Send from cursor to end of line to its own line above (alt-enter)
nnoremap <A-CR> d$0O<Esc>P
inoremap <A-CR> <Esc>ld$0O<Esc>Pa
vnoremap <A-CR> d0O<Esc>P


" Use esc on terminal to get out of insert mode
tnoremap <Esc> <C-\><C-n>

" use Alt-{h,j,k,l} in any mode to navigate windows
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Alt-Shift-{hl} to nav tabs
tnoremap <A-S-h> <C-\><C-N>gT
tnoremap <A-S-l> <C-\><C-N>gt
inoremap <A-S-h> <C-\><C-N>gT
inoremap <A-S-l> <C-\><C-N>gt
nnoremap <A-S-h> gT
nnoremap <A-S-l> gt

" Alt-Shift-{jk} to create/close tab
tnoremap <A-S-j> <C-\><C-N>:tabclose<Enter>
tnoremap <A-S-k> <C-\><C-N>:tabnew<Enter>
inoremap <A-S-j> <C-\><C-N>:tabclose<Enter>
inoremap <A-S-k> <C-\><C-N>:tabnew<Enter>
nnoremap <A-S-j> :tabclose<Enter>
nnoremap <A-S-k> :tabnew<Enter>

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
autocmd! BufNewFile,BufRead *.{js,html,css,ts}
    \ setlocal tabstop=2
    \ softtabstop=2
    \ shiftwidth=2
" }}}

" Ts {{{

autocmd! BufNewFile,BufRead *.ts
    \ setlocal filetype=typescript

" }}}

" Org mode {{{

autocmd! BufNewFile,BufRead *.org
    \ let maplocalleader="\\"

" }}}

" Start on insert mode when entering terminal
autocmd! BufEnter * if &buftype == 'terminal' | :startinsert | endif

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
" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/plugged/gruvbox/autoload/gruvbox.vim'))
    colorscheme desert
else
    colorscheme gruvbox
endif

"""""""""""""""""""""""""""""""""""""""""""""""""" }}}
