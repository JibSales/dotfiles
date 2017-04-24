"mark syntax errors with :signs
let g:syntastic_enable_signs=1
"automatically jump to the error when saving the file
let g:syntastic_auto_jump=0
"show the error list automatically
" let g:syntastic_auto_loc_list=1
"don't care about warnings
" let g:syntastic_quiet_messages = {'level': 'warnings'}
"linting javascript
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_jshint_args = '--config ~/.jshintrc'

"don't lint html cause they don't get angular
let g:syntastic_html_checkers=['']
