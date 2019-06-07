let g:onedark_termcolors=16
colorscheme onedark

" Create a background toggle
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
