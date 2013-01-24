"------------------------------------------------------------------------------
"Pathogen - Plugins Made Easy
"------------------------------------------------------------------------------
call pathogen#infect()
call pathogen#helptags()

"------------------------------------------------------------------------------
" General
"------------------------------------------------------------------------------
filetype on                " Detect filetype automatically
filetype plugin on         " Detect filetype with ftdetect script
syntax on                  " You could be crazy to not want Syntax Highlighting
set t_Co=256               " Some terminal emulators need this
color mango                " mmmmmm... mango... kick ass color scheme!
set nocompatible           " We call it vi IMPROVED for a reason...
set hidden                 " Ignore unsaved buffers when opening new file
set history=1000           " We like to keep lots of Command history

"------------------------------------------------------------------------------
" Format
"------------------------------------------------------------------------------
"set autoindent             " automatic indent new lines
"set copyindent             " copy the previous indentation on autoindenting
"set smartindent            " be smart about it
set nowrap                 " do not wrap lines
set softtabstop=2          " yep, two
set shiftwidth=2           " ..
set tabstop=4
"set expandtab              " expand tabs to spaces
"set nosmarttab             " fuck tabs
"set textwidth=80           " wrap at 80 chars by default

"------------------------------------------------------------------------------
" Visual
"------------------------------------------------------------------------------
set number                 " always show line numbers
set ruler                  " Its good to know your position
set showmatch              " set show matching parenthesis
set mat=5                  " duration to show paren match 1/10 sec

"------------------------------------------------------------------------------
" Custom Key Mappings
"------------------------------------------------------------------------------
" Map <F2> to show the current time
map <F2> :echo 'Current time is ' . strftime('%c')<CR>
" Map <F4> to toggle NERDTree
nmap <silent> <F6> :NERDTreeToggle<CR>

"------------------------------------------------------------------------------
" Auto Complete
"------------------------------------------------------------------------------


"------------------------------------------------------------------------------
" Filetypes
"------------------------------------------------------------------------------
autocmd BufNewFile,BufRead *.mustache,*.handlebars,*.hbs set filetype=mustache
au BufRead,BufNewFile /usr/local/nginx/conf/* set ft=nginx

"------------------------------------------------------------------------------
" Close Tag Plugin
"------------------------------------------------------------------------------
" Automatically close tags in HTML/XML file types
au Filetype html,xml,xsl,mustache source ~/.vim/bundle/closetag/scripts/closetag.vim

"------------------------------------------------------------------------------
" NERDTree Plugin
"------------------------------------------------------------------------------
" Show hidden files
let NERDTreeShowHidden=1
" Set space bar for selection
let NERDTreeMapActivateNode='<space>'
" Close NERDTree if its the only open buffer...
function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
"                     1BufNo  2Mods.     3File           4LineNo
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction
autocmd WinEnter * call NERDTreeQuit()
