if (has("termguicolors"))
  set termguicolors
endif

colorscheme onedark

" Create a background toggle
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
