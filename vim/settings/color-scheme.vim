if (has("termguicolors"))
  set termguicolors
endif

colorscheme one
set background=dark

function! BgToggle()
  if (&background ==? "light")
    set background=dark
  else
    set background=light
  endif
endfunction

nnoremap <leader>bg :call BgToggle()<cr>
