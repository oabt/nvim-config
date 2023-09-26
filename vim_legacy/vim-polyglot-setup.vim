
" vim-polyglot settings

" disable part of python highlight
let g:python_highlight_exceptions = 0
let g:python_highlight_indent_errors = 0
let g:python_highlight_space_errors = 0

"let g:polyglot_disabled = ['markdown']

autocmd BufNewFile,BufRead *.v set filetype=verilog

