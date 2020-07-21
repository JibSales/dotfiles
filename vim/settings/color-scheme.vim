if (has("termguicolors"))
  set termguicolors
endif

set background=dark
colorscheme one

function! BgToggle()
  if (&background ==? "light")
    set background=dark
  else
    set background=light
  endif
endfunction

nnoremap <leader>bg :call BgToggle()<cr>
