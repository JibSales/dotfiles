set nocompatible              " be iMproved, required
filetype off                  " required

"------------------------------------------------------------------------------
" Vundle Plugin Management
"------------------------------------------------------------------------------

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

"------------------------------------------------------------------------------
" Installed Plugins
"------------------------------------------------------------------------------

Plugin 'scrooloose/nerdtree'		        "File System Explorer
Plugin 'tpope/vim-fugitive'                 "Git Helper
Plugin 'tpope/vim-surround'                 "Text wrapping helper
Plugin 'bling/vim-airline'                  "Status bar/tabline
Plugin 'altercation/vim-colors-solarized'   "Because science
"Plugin 'Valloric/YouCompleteMe'             "Tab Completion
Plugin 'marijnh/tern_for_vim'               "Ternjs support
Plugin 'ervandew/eclim'                     "Headless eclipse integration
Plugin 'docunext/closetag.vim'              "Close tags with ease
Plugin 'pangloss/vim-javascript'            "Javascript syntax
Plugin 'scrooloose/nerdcommenter'           "Add/remove comments
Plugin 'burnettk/vim-angular'               "Angular tag lib
Plugin 'gabrielelana/vim-markdown'          "Markdown syntax highlighting

"------------------------------------------------------------------------------
" Vundle Plugin Configuration (cont.)
"------------------------------------------------------------------------------

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

"------------------------------------------------------------------------------
" General
"------------------------------------------------------------------------------

set hidden			 		" Ignore unsaved buffers when opening new file
set history=1000			" Keep lots of command history
set term=xterm-256color
set termencoding=utf-8
set backspace=indent,eol,start
set mouse=a

" Set Swap and Backup directory to something to avoid network overhead when
" working on network shares.
set directory=~/.vim/swaps
set backupdir=~/.vim/backups

"------------------------------------------------------------------------------
" Syntax Highlighting and Colors
"------------------------------------------------------------------------------

set t_Co=256
syntax enable
set background=dark
colorscheme solarized

"------------------------------------------------------------------------------
" Format
"------------------------------------------------------------------------------

set autoindent             " automatic indent new lines
set copyindent             " copy the previous indentation on autoindenting
set smartindent            " be smart about it
set nowrap                 " do not wrap lines
set softtabstop=4          " yep, four
set shiftwidth=4           " ..
set tabstop=4
set expandtab              " expand tabs to spaces
set nosmarttab             " fuck tabs

"------------------------------------------------------------------------------
" Format (by extension)
"------------------------------------------------------------------------------

" Markdown files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd FileType markdown set wrap linebreak
" Better zsh support
autocmd BufNewFile,BufRead *.zsh,*.zsh-* set filetype=zsh
" Git commits
autocmd FileType gitcommit set wrap linebreak

"------------------------------------------------------------------------------
" Visual
"------------------------------------------------------------------------------

set number                 " always show line numbers
set ruler                  " Its good to know your position
set showmatch              " set show matching parenthesis
set mat=5                  " duration to show paren match 1/10 sec

"------------------------------------------------------------------------------
" Key Mappings
"------------------------------------------------------------------------------

" ESC is too far away!
:imap jj <Esc>

" Toggle Light/Dark color theme
:map <F5> :let &background = ( &background == "dark"? "light" : "dark" )<CR>

"------------------------------------------------------------------------------
" NERDTree Config
"------------------------------------------------------------------------------

" Map CTRL-N to NERDTree toggle
map <silent> <C-n> :NERDTreeToggle<CR>

" Show hidden files
let NERDTreeShowHidden=1

" Filter files by extension
let NERDTreeIgnore=['\.DS_Store$','\.git$']

" Set space bar for selection
let NERDTreeMapActivateNode='<space>'

" Set shift space bar for opening in tab
let NERDTreeMapOpenInTab='<S-space>'

" Close NERDTree when file is opened
let NERDTreeQuitOnOpen=1

" Start NERDTree on open
autocmd VimEnter * if !argc() | NERDTree | endif

" Close NERDTree when its the last buffer
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

" move tabs to the end for new, single buffers (exclude splits)
autocmd BufNew * if winnr('$') == 1 | tabmove99 | endif

"------------------------------------------------------------------------------
" Airline Config
"------------------------------------------------------------------------------

set laststatus=2
let g:airline#extensions#tabline#enabled = 1
