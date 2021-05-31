compiler mingw32-make
nnoremap <buffer> <F5> :make<CR>
nnoremap <buffer> <F6> :make run<CR>

packadd termdebug
nnoremap <buffer> <F7> :Termdebug<CR>
nnoremap <buffer> <leader>i :Break<CR>
nnoremap <buffer> <leader>u :Clear<CR>

" let &l:define = '^\(#\s*define\|\S*\s*const\s*\S*\)'
