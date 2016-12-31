colo solarized
set background=dark

" Create a background toggle
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
