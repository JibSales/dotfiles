if exists("g:ctrlp_user_command")
  unlet g:ctrlp_user_command
endif
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Default to filename searches - so that appctrl will find application
" controller
let g:ctrlp_by_filename = 0

" Don't jump to already open window. This is annoying if you are maintaining
" several Tab workspaces and want to open two windows into the same file.
let g:ctrlp_switch_buffer = 0

" Use 'K' to search for the word under the cursor in command mode
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
