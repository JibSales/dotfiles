" Prevent weird behavior from ALE auto complete
set completeopt=menu,menuone,preview,noselect,noinsert

" Turn on autocomplete
let g:ale_completion_enabled = 1
" Trigger autocomplete with <C-x><C-o> while in INSERT mode
set omnifunc=ale#completion#OmniFunc
" Automatically import in typescript files
let g:ale_completion_autoimport = 1
" Fix files with prettier, and then ESLint.
let g:ale_fixers = {'typescript': ['eslint']}
let g:ale_fix_on_save = 1
