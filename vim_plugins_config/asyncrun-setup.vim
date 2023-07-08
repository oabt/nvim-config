"AsyncRun settings
let g:asyncrun_auto = "make"
"if has('win32')
"    let g:asyncrun_encs = 'gbk'
"endif

"augroup QuickfixStatus
"    au! BufWinEnter quickfix setlocal
"        \ statusline=%t\ [%{g:asyncrun_status}]\ %{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=%-15(%l,%c%V%)\ %P
"augroup END

"open quickfix when something adds to it
augroup vimrc
    autocmd QuickFixCmdPost * call asyncrun#quickfix_toggle(15, 1)
augroup END

"<Leader>q to toggle quickfix
noremap <Leader>q :call asyncrun#quickfix_toggle(15)<CR>
"noremap Q :call asyncrun#quickfix_toggle(20)<CR>

nnoremap <Leader>s :AsyncRun -raw 
nnoremap <Leader>S :AsyncStop<Cr>

"autumatically close quickfix if it is the only window left
aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

