"nerdcommenter settings
"" Add spaces after comment delimiters by default
" let g:NERDSpaceDelims = 1
" " Use compact syntax for prettified multi-line comments
" let g:NERDCompactSexyComs = 1
" " Align line-wise comment delimiters flush left instead of following code indentation
" commet delimiters insert from the 'start' of lines
" let g:NERDDefaultAlign = 'start'
" " Set a language to use its alternate delimiters by default
" let g:NERDAltDelims_java = 1
" " Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" " Allow commenting and inverting empty lines (useful when commenting a region)
" let g:NERDCommentEmptyLines = 1
" " Enable trimming of trailing whitespace when uncommenting
" let g:NERDTrimTrailingWhitespace = 1

"let g:NERDAltDelims_c = 1
let g:NERDCustomDelimiters = {
            \'c': {'left': '//'}
            \}
let g:NERDDefaultAlign = 'left'

