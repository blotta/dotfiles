" OS and GUI {{{
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
		let g:os = "Windows"
        " echom "Windows"
        " TODO: Check path is right. Might need $USERPROFILE instead. Or $env:USERPROFILE
        let g:nv_cfg_path = expand('~/AppData/Local/nvim')
        let g:nv_data_path = expand('~/AppData/Local/nvim-data')
	else
		let g:os = substitute(system('uname'), '\n', '', '')
        " echom "Not Windows"
        let g:nv_cfg_path = expand($HOME . "/.config/nvim")
        let g:nv_data_path = expand($HOME . "/.config/nvim")
	endif
endif
" TODO: older versions of nvim (e.g 0.2) don't support stdpath.
" echom "cfg " . g:nv_cfg_path
" echom "data " . g:nv_data_path

function NoGuiPopup()
    if exists('g:GuiLoaded')
        " echom 'InGUI'
        GuiPopupmenu 0
    else
        " echom 'Not InGUI'
        set t_Co=256
    endif
endfunction
au VimEnter * call NoGuiPopup()

function AdjustFont()
    if exists('g:GuiLoaded')
        " set guifont=:h12
        " set guifont=Fira\ Code:h12
        set guifont=Consolas:h13
    endif
endfunction
au VimEnter * call AdjustFont()
" }}}

" Plugins (clone in $RTP/pack/plugins/(start|opt)/) {{{
" 'tpope/vim-commentary'
" 'tpope/vim-surround'
" --'tpope/vim-fugitive'
" --'tpope/vim-sensible'
" --'itchyny/lightline.vim'
" 'lokaltog/vim-distinguished'
" }}}

set nocompatible
filetype plugin on

set smartindent
set smartcase
set ignorecase
set noswapfile
set number numberwidth=4
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
set mouse=a
set incsearch
set autoread
set scrolloff=7
set clipboard+=unnamedplus
set encoding=utf-8

set path+=**
set wildmenu
set hidden

set splitright

" wild spaces
set list listchars=tab:\ \ ,trail:·

let mapleader="\<space>"

" Mappings {{{

" General/Misc {{{
"
" Edit and source nvim config
nnoremap <leader>ce :tabnew $MYVIMRC<CR>
nnoremap <leader>cs :source $MYVIMRC<CR>

" Save file with F2
nnoremap <F2> :w<CR>
inoremap <F2> <ESC>:w<CR>a

" ABNT
nnoremap Ç :

" Alt Enter
nnoremap <A-CR> d$0O<Esc>P
inoremap <A-CR> <ESC>ld$0O<Esc>Pa
vnoremap <A-CR> d0O<Esc>P

" Open netrw to the left, 15 chars wide
nnoremap <leader>n :15Lexplore<CR>

" Open file explorer on :pwd
nnoremap <leader>e :!start explorer .<CR>
" }}}

" Navigation {{{
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

" SPC-{hl} to move between buffers
nnoremap <leader>h :bprevious<CR>
nnoremap <leader>l :bnext<CR>
" }}}

""""""""""""""""""""""""""""""""""""""""" Mappings }}}

" Hooks {{{
" Apply folding to nvim config
autocmd! BufReadPost init.vim setlocal foldmethod=marker

" }}}

" Terminal {{{

" Term Mappings {{{

" Open term
nnoremap <leader>tt :terminal<Enter>a
nnoremap <silent> <leader>th :sp<Enter><C-w>j:terminal<Enter>:resize 12<Enter>a
nnoremap <leader>tv :vs<Enter><C-w>l:terminal<Enter>a

" Use esc on terminal to get out of insert mode
tnoremap <Esc> <C-\><C-n>

" Paste from register. :h terminal-input
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" }}}

" Term Hooks {{{

" Start on insert mode when entering terminal
" autocmd! BufEnter * if &buftype == 'terminal' | :startinsert | endif
autocmd! TermEnter :startinsert

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""" }}}

" Theme {{{

" status line
set laststatus=2
set noshowmode
" let g:lightline = {
"     \ 'colorscheme':  'jellybeans',
"     \ 'active': {
"     \   'left': [ [ 'mode', 'paste' ],
"     \           [ 'gitbranch', 'readonly', 'filename', 'modified', 'cocstatus' ] ]
"     \ },
"     \ 'component_function': {
"     \   'gitbranch': 'fugitive#head',
" 	\   'cocstatus': 'coc#status',
"     \ },
"     \ }

    " \ 'colorscheme':  'jellybeans',
    " \           [ 'gitbranch', 'readonly', 'filename', 'modified'] ]
    " \   'gitbranch': 'fugitive#head',
    " %{get(b:,'coc_current_function','')
    " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" set background so themes play nice
set background=dark
" colorscheme desert
colorscheme distinguished

" }}}
