" configuration of GUI nvim

Guifont! DejaVuSansMono Nerd Font Mono:h11
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
