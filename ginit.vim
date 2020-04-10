" configuration of GUI nvim

Guifont! DejaVuSansMono Nerd Font Mono:h11

set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
            \,a:blinkwait1000-blinkoff500-blinkon500-Cursor/lCursor
            \,sm:block-blinkwait175-blinkoff150-blinkon175
"set guicursor=

"Guifont! Consolas:h13
"silent! call rpcnotify(1, 'Gui', 'Font', 'DejaVuSansMono Nerd Font Mono:h11')
"

"silent! call GuiWindowMaximized(1)

noremap <F11> :call ToggleFullScreen()<cr>

function! ToggleFullScreen()
    if g:GuiWindowFullScreen == 1
        call GuiWindowFullScreen(0)
        call GuiWindowMaximized(1)
    else 
        call GuiWindowFullScreen(1)
    endif
endfunction

nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
"inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
