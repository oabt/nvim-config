" Neosnippet settings
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
if has('win32')
    let g:neosnippet#snippets_directory = '$HOME/AppData/Local/nvim/snippets'
elseif has('unix')
    let g:neosnippet#snippets_directory = '$HOME/.config/nvim/snippets'
endif
imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)

