" Turn on autocomplete
" let g:ale_completion_enabled = 1
" Trigger autocomplete with <C-x><C-o> while in INSERT mode
set omnifunc=ale#completion#OmniFunc
" Automatically import in typescript files
let g:ale_completion_tsserver_autoimport = 1
" Fix files with prettier, and then ESLint.
let b:ale_fixers = ['prettier', 'eslint']
