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
        set guifont=:h12
        set guifont=Fira\ Code:h12
    endif
endfunction
au VimEnter * call AdjustFont()
" }}}

" Plug {{{
" Install Vim Plug if not installed
if empty(glob(stdpath('config') . "/autoload/plug.vim"))
    execute('!curl -fLo ' . stdpath('config') . "/autoload/plug.vim" . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    autocmd VimEnter * PlugInstall
endif

call plug#begin(stdpath('data') . '/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'

Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'morhetz/gruvbox'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'itchyny/lightline.vim'
call plug#end()
" }}}


set smartindent
set smartcase
set noswapfile
set number numberwidth=4
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
set mouse=a
set incsearch ignorecase smartcase
set autoread
set clipboard+=unnamedplus
set encoding=utf-8

set path+=**
set wildmenu
set wildignore+=**/node_modules/**
set hidden

let mapleader="\<space>"

" Mappings {{{

" General/Misc {{{
" Edit and source nvim config
nnoremap <leader>ce :execute(':tabnew ' . stdpath('config') . "/init.vim")<cr>
nnoremap <leader>cs :execute(':source ' . stdpath('config') . "/init.vim")<cr>

" Save file with F2
nnoremap <F2> :w<CR>
inoremap <F2> <ESC>:w<CR>a

" ABNT
nnoremap Ç :

" Send text from cursor until end o line to its own line above (alt-enter)
nnoremap <A-CR> d$0O<Esc>P
inoremap <A-CR> <ESC>ld$0O<Esc>Pa
vnoremap <A-CR> d0O<Esc>P
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

if g:os == "Windows"
    " from :h shell-powershell -- does not work
    " let &shell = has('win32') ? 'powershell' : 'pwsh'
    " set shellquote= shellpipe=\| shellxquote=
    " set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
    " set shellredir=\|\ Out-File\ -Encoding\ UTF8
endif

" Term Mappings {{{

" Open term
nnoremap <leader>tt :terminal<Enter>a
nnoremap <silent> <leader>th :sp<Enter><C-w>j:terminal<Enter>:resize 12<Enter>a
nnoremap <leader>tv :vs<Enter><C-w>l:terminal<Enter>a

" Use esc on terminal to get out of insert mode
tnoremap <Esc> <C-\><C-n>

" }}}

" Term Hooks {{{

" Start on insert mode when entering terminal
" autocmd! BufEnter * if &buftype == 'terminal' | :startinsert | endif
autocmd! TermEnter :startinsert
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""" }}}

" Completion (CoC) {{{
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" " }}}

" NERDTree {{{
map <leader>n :NERDTreeToggle<CR>
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}

" CtrlP {{{
" https://github.com/ctrlpvim/ctrlp.vim

" binding
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
nnoremap <leader>b :CtrlPBuffer<CR>

" search dir
let g:ctrlp_working_path_mode = 'ra'
" a - dir of current file, unless it is a subdir of cwd
" r - the nearest ancestor of current file that contains one of .git, .hg, etc

" exclude files and dirs using wildignore and CtrlP's own ignore var
if g:os == "Windows"
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
else
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip
endif
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" file listing command
if g:os == "Windows"
    let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'
else
    let g:ctrlp_user_command = 'find %s -type f'
endif


" }}}

" Theme {{{

" status line
set laststatus=2
set noshowmode
let g:lightline = {
    \ 'colorscheme':  'jellybeans',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \           [ 'gitbranch', 'readonly', 'filename', 'modified', 'cocstatus' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head',
	\   'cocstatus': 'coc#status',
    \ },
    \ }

    " \ 'colorscheme':  'jellybeans',
    " \           [ 'gitbranch', 'readonly', 'filename', 'modified'] ]
    " \   'gitbranch': 'fugitive#head',
    " %{get(b:,'coc_current_function','')
    " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" wild spaces
set list listchars=tab:\ \ ,trail:·

" yes, more than 80
set colorcolumn=100
highlight ColorColumn ctermbg=0 guibg=lightgrey

" set background so themes play nice
set background=dark

" try gruvbox, else builtin desert
if !empty(glob(stdpath('data') .  "/plugged/vim-hybrid-material/colors/hybrid_reverse.vim"))
    " Using hybrid-reverse theme
    colorscheme hybrid_reverse
elseif !empty(glob(stdpath('data') . "/plugged/gruvbox/colors/gruvbox.vim"))
    " Falling back to gruvbox
    let g:gruvbox_contrast_dark = 'soft'
    colorscheme gruvbox
else
    " Falling back to builtin theme
    colorscheme desert
endif
" }}}
