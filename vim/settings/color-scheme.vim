"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
if (has("termguicolors"))
  set termguicolors
endif

set background=dark
set t_Co=256
colorscheme onedark

" Create a background toggle
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
