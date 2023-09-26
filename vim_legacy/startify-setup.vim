
"startify settings
let g:startify_session_dir = '~/.nvim/sessions'
let g:startify_disable_at_vimenter = 0
let g:startify_enable_unsafe = 1
let g:startify_custom_header = [
            \'                  ,---------------------------,                        ', 
            \'                  |  /---------------------\  |                        ', 
            \'                  | | oabt:~$ nvim          | |                        ', 
            \'                  | |                       | |                        ', 
            \'                  | |                       | |                        ', 
            \'                  | |                       | |                        ', 
            \'                  | |                       | |                        ', 
            \'                  |  \_____________________/  |                        ', 
            \'                  |___________________________|                        ', 
            \'                ,---\_____     []     _______/------,                  ', 
            \'              /         /______________\           /|                  ', 
            \'            /___________________________________ /  | ___              ', 
            \'            |  _ _ _                            |   |   (              ', 
            \'            |  o o o                 [-------]  |  /    _)_            ', 
            \'            |__________________________________ |/     /  /            ', 
            \'        /-------------------------------------/|      ( )/             ', 
            \'      /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/ /                        ', 
            \'    /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/ /                          ', 
            \'    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                            ', 
            \]
function s:startify_plugin_list() "the list of Plugin Manager Operations
    return [
                \{'line': 'Plugin Status', 'cmd': 'exec "Lazy"'},
                \{'line': 'Plugin Update', 'cmd': 'exec "Lazy update"'},
                \{'line': 'Plugin Profiling', 'cmd': 'exec "Lazy profile"'},
                \]
endfunction

let g:startify_lists = [
            \{
            \   'type': function('s:startify_plugin_list'),
            \   'header': ['    Plugin Options:'],
            \   'indices': ['L', 'U', 'P'],
            \},
            \{'type': 'sessions', 'header': ['    Sessions:']},
            \]
