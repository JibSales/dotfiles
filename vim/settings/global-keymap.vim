" ========================================
" General vim sanity improvements
" ========================================

"Move back and forth through previous and next buffers
"with ,z and ,x
nnoremap <silent> ,z :bp<CR>
nnoremap <silent> ,x :bn<CR>

" Zoom in
map <silent> ,gz <C-w>o

" Undo highlight
noremap <silent> <Space> :set hls!<CR>
