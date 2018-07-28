" ###################### "OABT NVIM CONFIGURATION FILE" ####################

    "install the vim-plug in Powershell
    "call plug#begin('~/vimfiles/plugged') 
    "call plug#begin('$VIM/../../plugins') 
"call plug#begin('$HOME/nvimfiles/plugins') 
"call plug#begin('$HOME/nvimfiles/plugged') 
silent! call plug#begin('$HOME/.nvim/plugged') 
    
    """"""""""""""""""""""""""""git integration""""""""""""""""""""""""""""""""""
    "Plug 'tpope/vim-fugitive'
    "Plug 'airblade/vim-gitgutter'
    Plug 'mhinz/vim-signify'
    """"""""""""""""""""""""""""user interface""""""""""""""""""""""""""""""""""
    "Plug 'equalsraf/neovim-gui-shim'
    "Plug 'morhetz/gruvbox'
    Plug 'itchyny/lightline.vim'
    Plug 'mhinz/vim-startify'
    Plug 'sheerun/vim-polyglot'
    Plug 'ryanoasis/vim-devicons'
    
    """""""""""""""""""""""""""completion""""""""""""""""""""""""""""""""""
    Plug 'Shougo/neosnippet.vim'
    Plug 'Shougo/neosnippet-snippets'
    
    "Plug 'roxma/nvim-yarp'
    "Plug 'ncm2/ncm2'
    "Plug 'ncm2/ncm2-bufword'
    "Plug 'ncm2/ncm2-path'
    "Plug 'ncm2/ncm2-jedi'
    "Plug 'ncm2/ncm2-pyclang'

    Plug 'roxma/nvim-completion-manager'
    Plug 'fgrsnau/ncm-otherbuf'
    Plug 'roxma/ncm-clang', {'for': ['c', 'cpp']}
    "Plug 'roxma/nvim-cm-tern',  {'do': 'npm install', 'for': ['javascript']}
    "Plug 'Shougo/neco-vim', {'for': 'vim'}
    "Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
    "Plug 'tweekmonster/deoplete-clang2', {'for': ['c', 'cpp']}
    "Plug 'zchee/deoplete-jedi', {'for': 'python'}
    
    """""""""""""""""""""""""linters""""""""""""""""""""""""""""""""""""""""""
    Plug 'skywind3000/asyncrun.vim'
    "Plug 'vim-scripts/errormarker.vim'
    "Plug 'w0rp/ale'
    "if buffer size exceed 2048KB do not load 'ale'
    if getfsize(expand(@%)) < 2048000
        "Plug 'w0rp/ale', {'on': 'ALEToggle'}
        Plug 'w0rp/ale'
    endif
    "Plug 'neomake/neomake'

    """"""""""""""""""""""""""editing"""""""""""""""""""""""""""""""""""""""
    "Plug 'iamcco/markdown-preview.vim', {'for': ['markdown']}
    "Plug 'iamcco/mathjax-support-for-mkdp', {'for': ['markdown']}
    Plug 'junegunn/vim-easy-align'
    "Plug 'sjl/gundo.vim'
    "Plug 'mbbill/undotree' , {'on': 'UndotreeToggle'}
    Plug 'tpope/vim-surround'
    Plug 'scrooloose/nerdcommenter'
    Plug 'jiangmiao/auto-pairs'
    
    """""""""""""""""""""""""Navigation""""""""""""""""""""""""""""""""""""""""""
    "Plug 'ctrlpvim/ctrlp.vim'
    "Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    "Plug 'junegunn/fzf.vim'
    "Plug 'majutsushi/tagbar' , {'on': 'TagbarToggle'}
    Plug 'Shougo/denite.nvim', {'do': ':UpdateRemotePlugins'}
    Plug 'Lokaltog/vim-easymotion'
    Plug 'scrooloose/nerdtree' , {'on': 'NERDTreeToggle'}
    Plug 'ludovicchabant/vim-gutentags'

call plug#end()

"let $NVIM_PYTHON_LOG_FILE="nvimlog"
if has('win32')
    let g:python3_host_prog='C:\miniconda3\python.exe'
elseif has('unix')
    let g:python3_host_prog='/home/oabt/miniconda3/bin/python'
endif
syntax on
syntax enable
set number
set backspace=indent,eol,start  "try if backspace does't work in indent
set splitright
set splitbelow
set belloff=all  "never ring the bells
filetype plugin on
filetype indent on 
filetype plugin indent on

autocmd BufEnter * silent! lcd %:p:h  "equivalent to autochdir but work better with plugins

set timeoutlen=400
set updatetime=400
set autoindent
set cindent
set smartindent
set completeopt=longest,menu
set wildmenu  "enhance command-line mode completion"
set viminfo='250,<50,s10,h,rA:,rB: "modifiy oldfile history length"

set showtabline=2
set laststatus=2
set undodir=$HOME/.nvim/undo
set termguicolors  "use true color in terminal"
"set signcolumn=yes

set hlsearch
set ignorecase
set smartcase
set incsearch
set inccommand=nosplit

set mouse=v  "enable mouse in Normal mode"
set selection=exclusive
set selectmode=key,mouse
set showcmd
set scrolloff=4  "left 4 lines below/above when scrolling below/above
set cursorline

set expandtab
set tabstop=4  "use 4 <space> to replace tab
set shiftwidth=4  "width shift with >> or <<"
set softtabstop=4  "backspace 4 space if possible"

set encoding=utf-8 
set fileencoding=utf-8

set foldmethod=indent  "fold/unfold base on the indentaion"
set foldlevelstart=99  "disable indentatino when startup"

set nowrap  "no wrap in default, switching j and gj, k and gk
noremap j gj
noremap k gk
noremap gj j
noremap gk k
"noremap 0 g0
"noremap $ g$
"noremap g0 0
"noremap g$ $

" automatically toggle between wrap and nowrap
autocmd BufEnter * if &filetype == 'markdown' || &filetype == 'text'
            \| set wrap | else | set nowrap | endif

"when open buffer, automatically jump to the position of last access
autocmd BufReadPost * if line("'\"")>0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

"set fillchars=vert:'|'  "set the char of verti_split seperator


"set the error mark style
"autocmd VimEnter * hi Error term=bold cterm=bold ctermfg=9 ctermbg=NONE gui=bold guifg=#FF0000 guibg=NONE guisp=#F44747

imap fd <ESC><Esc><Right>

"change the <Leader> :let mapleader=" " <space>
let mapleader=" "
map <Leader>w :w<cr>

"set pastetoggle=<Leader>p
nnoremap <Leader>s :AsyncRun 
map <Leader>/ :nohlsearch<CR>
nmap <F2> :tabnew $MYVIMRC<CR>:vs ginit.vim<CR><C-W>h
nmap ;t :tabnew<cr>:Startify<cr>

if has('win32')
    " open cwd in Explorer
    nnoremap f<C-f> :silent! !start explorer . <cr><cr>
    nmap <C-t> :split term://cmd <cr>i
    "nmap <C-t> :split term://powershell <cr>i
elseif has('unix')
    nmap <C-t> :split term://bash <cr>i
endif
noremap <Leader>t :split term://

tnoremap fd <C-\><C-n>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
tnoremap <C-w>H <C-\><C-n><C-w>Hi
tnoremap <C-w>J <C-\><C-n><C-w>Ji
tnoremap <C-w>K <C-\><C-n><C-w>Ki
tnoremap <C-w>L <C-\><C-n><C-w>Li
tnoremap <C-w>T <C-\><C-n><C-w>Ti

map fk 20k
map fj 20j
map fl 15l
map fh 15h
map fzl 20zl
map fzh 20zh
inoremap <M-h> <Left>
inoremap <M-l> <Right>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
nnoremap <C-l> 7zl
nnoremap <C-h> 7zh

nnoremap Q :q<cr>
nnoremap ;;l gt
nnoremap ;;h gT
nnoremap ;j <C-w>j
nnoremap ;k <C-w>k
nnoremap ;h <C-w>h
nnoremap ;l <C-w>l
nnoremap 1t :1tabn<cr>
nnoremap 2t :2tabn<cr>
nnoremap 3t :3tabn<cr>
nnoremap 4t :4tabn<cr>
nnoremap 5t :5tabn<cr>
nnoremap 6t :6tabn<cr>
nnoremap 7t :7tabn<cr>
nnoremap 8t :8tabn<cr>
nnoremap 9t :9tabn<cr>
nnoremap <M-l> 2<C-w>>
nnoremap <M-h> 2<C-w><
nnoremap <M-k> <C-w>+
nnoremap <M-j> <C-w>-

map <C-Left> :tabprevious <CR>
map <C-Right> :tabnext <CR>
"nnoremap f<C-f> :split term://explorer .<cr>
nnoremap <Leader>f :vimgrep //j %<Left><Left><Left><Left>

"<F5> to run,<F6>to compile,<F7> to clean <Leader>m to make
map <Leader>m :wa<CR>:AsyncRun make <CR>
if has('win32')
    map <F7> :AsyncRun make clean & del /Q %:r.exe %:r.vvp<CR>
elseif has('unix')
    map <F7> :AsyncRun make clean ; rm -f ./%:r.run ./%:r.vvp<CR>
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compile or lint current file
map <F6> :call Compile()<CR>
func! Compile()
    exec "w"
    if &filetype == 'c'
        if has('win32')
            "exec "AsyncRun gcc % -g -O2 -Wall -o %:r.exe"
            exec "AsyncRun clang % -O2 -Wall -o %:r.exe"
        elseif has('unix')
            exec "AsyncRun gcc % -g -O2 -Wall -o %:r.run"
            "exec "AsyncRun clang % -O2 -Wall -o %:r.run"
        endif
    elseif &filetype == 'cpp'
        if has('win32')
            "exec "AsyncRun g++ % -g -O2 -Wall -o %:r.exe"
            exec "AsyncRun clang++ % -O2 -Wall -o %:r.exe"
        elseif has('unix')
            exec "AsyncRun g++ % -g -O2 -Wall -o %:r.run"
            "exec "AsyncRun clang++ % -O2 -Wall -o %:r.run"
        endif
    elseif &filetype == 'verilog' 
		exec "AsyncRun iverilog -Wall -o %:r.vvp %" 
	elseif &filetype == 'python'
        exec "AsyncRun flake8 %"
        "exec "split term://python %"
    elseif &filetype == 'markdown'
        if has('win32')
            "exec "!pandoc % -s -t html5 --katex=I:/katex/katex.js --katex-stylesheet=I:/katex/katex.css --css C:/Users/oabt/AppData/Roaming/Typora/themes/github.css -o %:r.html"
            exec "!pandoc % -t html5 --mathjax=I:/MathJax/MathJax.js?config=TeX-MML-AM_CHTML --css C:/Users/oabt/AppData/Roaming/Typora/themes/github.css -o %:r.html"
            exec "!chrome %:r.html"
            "exec "!pandoc % -t html5 --mathjax=I:/MathJax/MathJax.js?config=TeX-MML-AM_SVG --css C:/Users/oabt/AppData/Roaming/Typora/themes/github.css -o %:r.pdf"
        elseif has('unix')
            exec "!pandoc % -t html5 --mathjax=/home/oabt/Public/MathJax/MathJax.js?config=TeX-MML-AM_CHTML --css /home/oabt/.config/Typora/themes/github.css -o %:r.html"
            exec "!google-chrome %:r.html"
        endif
        "exec "!pandoc % -s -t html5 --katex=I:/katex/katex.js --katex-stylesheet=I:/katex/katex.css --css C:/Users/oabt/AppData/Roaming/Typora/themes/github.css -o %:r.html"
        "exec "AsyncRun pandoc % -t html5 --mathjax=I:/MathJax/MathJax.js?config=TeX-MML-AM_SVG --css C:/Users/oabt/AppData/Roaming/Typora/themes/github.css -o %:r.html"
    endif
endfunc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Running exes or sripts
map <F5> :call Run()<CR>
func! Run()
	if &filetype == 'c'
        if has('win32')
            exec "split term://%:r.exe"
        elseif has('unix')
            exec "split term:// ./%:r.run"
        endif
        exec "startinsert"
	elseif &filetype == 'cpp'
        if has('win32')
            exec "split term://%:r.exe"
        elseif has('unix')
            exec "split term:// ./%:r.run"
        endif
        exec "startinsert"
	elseif &filetype == 'verilog'
		"exec "!start cmd /c vvp %:r.vvp & pause"
        exec "split term://vvp %:r.vvp"
        exec "startinsert"
	elseif &filetype == 'python'
		exec "w"
        exec "split term://python %"
        exec "startinsert"
    elseif &filetype == 'matlab'
		exec "w"
        exec "AsyncRun matlab -nodesktop -nosplash -r \"try, run(which('%')), end\" "
    elseif &filetype == 'markdown'
        exec "w"
        if has('win32')
            exec "silent! !start Typora %"
        elseif has('unix')
            exec "!typora % &"
        endif
    elseif &filetype == 'html'
        if has('win32')
            exec "!chrome %"
        elseif has('unix')
            exec "!google-chrome %"
        endif
	endif
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" wipe out all the inactive buffers opend in NONE window
function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    "create a unload buffer for complete otherbuf
    exec "badd _ncm-otherbuf"
    exec "bdelete _ncm-otherbuf"
    echomsg nWipeouts - 1 >= 0 ? nWipeouts - 1 . ' buffer(s) wiped out' : 0 . ' buffer(s) wiped out'
endfunction
"command! Bdi :call DeleteInactiveBufs()
nnoremap <F3> :call DeleteInactiveBufs()<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
let g:startify_list_order = [
            \   ['    Sessions:'], 
            \   'sessions',
            \   ]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-polyglot settings

" disable part of python highlight
let g:python_highlight_exceptions = 0
let g:python_highlight_indent_errors = 0
let g:python_highlight_space_errors = 0

"let g:polyglot_disabled = ['markdown']
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"devicons settings
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_denite = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"AutoPairs settings
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"'}
"au Filetype markdown let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"','$':'$'}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline settings
"set noshowmode
"colorscheme codedark
"colorscheme gruvbox

colorscheme molokai
"colorscheme neosolarized
"set background=light

let g:lightline = {}
"let g:lightline.colorscheme = 'solarized'
"
let g:lightline.winwidth = 200

let g:lightline.component = {}
let g:lightline.component.lineinfo = '%1p%%  %2l:%-2v'
let g:lightline.component.modified = '%{LightlineModified()}'
let g:lightline.component.gutentags = '%{gutentags#statusline()}'
let g:lightline.component.asyncrun = '%{g:asyncrun_status}'

let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }

let g:lightline.component_function = {}
let g:lightline.component_function.gitdir = 'LightlineGitDir'
let g:lightline.component_function.filetype = 'MyFiletype'
let g:lightline.component_function.fileformat = 'MyFileformat'

let g:lightline.tab_component_function = {}
let g:lightline.tab_component_function.tabmodified = 'LightlineTablineModified'

let g:lightline.component_expand = {}
let g:lightline.component_expand.readonly = 'LightlineReadonly'
let g:lightline.component_expand.linter_warnings = 'LightlineLinterWarnings'
let g:lightline.component_expand.linter_errors = 'LightlineLinterErrors'

let g:lightline.component_type = {}
let g:lightline.component_type.readonly = 'error'
let g:lightline.component_type.linter_warnings = 'warning'
let g:lightline.component_type.linter_errors = 'error'

let g:lightline.active = {
            \'left': [  ['mode', 'paste',],
            \           ['readonly', 'gitdir', 'filename', 'filetype', 'modified'],
            \           ['gutentags']] ,
            \'right': [ ['lineinfo'],
            \           ['fileformat', 'fileencoding', 'linter_warnings', 'linter_errors'] ],
            \}

let g:lightline.inactive = {
            \'left': [[], ['relativepath', 'filetype'],  ['modified'] ],
            \'right': [ [ 'lineinfo' ], ],
            \}

let g:lightline.tab = {
            \'active': [ 'tabnum', 'filename', 'tabmodified',],
            \'inactive': [ 'tabnum', 'filename', 'tabmodified',],
            \}
"let g:lightline = {}

" filetype symbol
function! MyFiletype()
    if exists('*WebDevIconsGetFileTypeSymbol')
        return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : '') : ''
    else
        return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' : '') : ''
    endif
endfunction

" filformat symbol(unix, dos, mac)
function! MyFileformat()
    if exists('*WebDevIconsGetFileFormatSymbol')
        return winwidth(0) > 70 ? (WebDevIconsGetFileFormatSymbol()) : ''
    else
        return winwidth(0) > 70 ? (&fileformat . ' ') : ''
    endif
endfunction

" Readonly symbol
function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction

" tab modified(if any window within tab modified)
function! LightlineTablineModified(n)
	let l:window_number = tabpagewinnr(a:n, '$')
	let l:modified = v:false
	let l:unmodifiable = v:true
	for winnr in range(1, l:window_number)
		let l:modified = l:modified || gettabwinvar(a:n, winnr, '&modified')
		let l:unmodifiable = l:unmodifiable && !gettabwinvar(a:n, winnr, '&modifiable')
	endfor
	let l:string = ''
	if l:modified
		let l:string .= ''
	elseif l:unmodifiable
		let l:string .= '-'
	endif
	return l:string
endfunction

" customize modified sign
function! LightlineModified()
    "return &modified ? '' : ''  "/f111
    "return &modified ? '' : ''   "/f055
    return &modified ? '' : ''  "/f067
endfunction

" ale warnings
function! LightlineLinterWarnings() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%d ', all_non_errors)
endfunction

" ale errors
function! LightlineLinterErrors() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%d ✖', all_errors)
endfunction
autocmd User ALELint call lightline#update()

" decide whether in git dir
function! LightlineGitDir() abort
    if finddir(".git", ";") != ""
        return ""
    else
        return ""
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"easy-align settings
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyMotion settings
"map <Leader><Leader> <Plug>(easymotion-prefix)
map <Leader>e <Plug>(easymotion-prefix)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gitgutter/fugitive/signify settings
"let g:gitgutter_grep = 'rg --color never'
"highlight GitGutterAdd      cterm=bold ctermbg=None ctermfg=119 guibg=None guifg=#87ff5f
"highlight GitGutterDelete   cterm=bold ctermbg=None ctermfg=198 guibg=None guifg=#ff0087
"highlight GitGutterChange   cterm=bold ctermbg=None ctermfg=227 guibg=None guifg=#ffff5f

let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '-'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
highlight SignifySignAdd      cterm=bold ctermbg=None ctermfg=119 guibg=None guifg=#87ff5f
highlight SignifySignDelete   cterm=bold ctermbg=None ctermfg=167 guibg=None guifg=#d75f5f
highlight SignifySignChange   cterm=bold ctermbg=None ctermfg=227 guibg=None guifg=#ffff5f
command! Gvdiff exec "SignifyDiff"
command! Glist exec "SignifyList"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gutentags settings
"nnoremap <M-a> :scs find a <C-R>=expand("<cword>")<cr><cr>
"nnoremap <M-d> :scs find d <C-R>=expand("<cword>")<cr><cr>
nnoremap <M-c> :scs find c <C-R>=expand("<cword>")<cr><cr>
nnoremap <M-g> :scs find g <C-R>=expand("<cword>")<cr><cr>
nnoremap <M-r> :silent! cs reset<cr>

nnoremap <M-;> :tnext<cr>
nnoremap <M-'> :tprevious<cr>

"let g:gutentags_define_advanced_commands = 1
"let g:gutentags_trace = 1

let g:gutentags_project_root = ['.root']
let g:gutentags_add_default_project_roots = 0
let g:gutentags_cache_dir = '~/.cache/tags/'
let g:gutentags_modules = []

"set cscopequickfix=s-,c-,d-,i-,t-,e-,a-,g-
"set cscopetag 

let g:gutentags_modules += ['gtags_cscope']
"autocmd DirChanged * 
"            \if exists(":GutentagsUpdate") | exec 'silent! cs reset' | endif
let $GTAGSLABEL = 'native-pygments'
if has('win32')
    set cscopeprg="~/gnu_global/bin/gtags-cscope.exe"
    let $GTAGSCONF = expand($HOME) . '\gnu_global\share\gtags\gtags.conf'
elseif has('unix')
    set cscopeprg="~/Public/gtags_build/bin/gtags-cscope"
    let $GTAGSCONF = expand($HOME) . '/Public/gtags_build/share/gtags/gtags.conf'
endif

set cscopetagorder=1
let g:gutentags_modules += ['ctags']
let g:gutentags_ctags_extra_args = []
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
let g:gutentags_ctags_extra_args += ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--verilog-kinds=+px']
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"AsyncRun settings
let g:asyncrun_auto = "make"
if has('win32')
    let g:asyncrun_encs = 'gbk'
endif

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

"autumatically close quickfix if it is the only window left
aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"ale settings
"let g:ale_lint_on_enter = 1
let g:ale_maximum_file_size = 2048000
let g:ale_lint_on_save = 0
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_delay = 0
let g:ale_set_quickfix = 0
let g:ale_sign_column_always = 1
let g:ale_sign_error="✖" "/0x2715~0x2718
let g:ale_sign_warning="" "/uf071
let g:ale_linters = {
            \'c' : ['clang'],
            \'cpp' : ['clang'],
            \'verilog' : ['iverilog'],
            \'python'  : ['flake8'],
            \'asm' : [''],
            \'matlab' : ['']
            \}
nmap <silent> <Leader>h <Plug>(ale_previous_wrap)
nmap <silent> <Leader>l <Plug>(ale_next_wrap)
nmap <M-e> :ALEToggle<CR>
let g:ale_python_flake8_options = 
    \'--ignore=E301,E303,E305,E405,E501,W391,F401,E731,E128,E402,E702,F841,E722'
if has('win32')
    "let g:ale_c_clang_options = "-std=c11 -Wall --target=x86_64-windows-gnu"
    "let g:ale_cpp_clang_options = "-std=c++14 -Wall --target=x86_64-windows-gnu"
endif

"silent! call neomake#configure#automake('nrw', 0)
let g:neomake_open_list = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF/Denite settings
silent! call denite#custom#map('insert', '<C-a>', '<Home>')
silent! call denite#custom#map('insert', '<C-e>', '<End>')
silent! call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>')
silent! call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>')
silent! call denite#custom#map('insert', '<C-i>', '<denite:toggle_select>')
silent! call denite#custom#map('insert', '<C-s>', '<denite:do_action:split>')
silent! call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>')
silent! call denite#custom#map('insert', '<C-t>', '<denite:do_action:tabopen>')
silent! call denite#custom#map('normal', 's', '<denite:do_action:split>')
silent! call denite#custom#map('normal', 'v', '<denite:do_action:vsplit>')

silent! call denite#custom#var('file/rec', 'command',  ['rg', '--files', '--no-ignore', '--follow', '--hidden', '--color', 'never'])
"silent! call denite#custom#source('file/rec', 'max_candidates', 30000)

silent! call denite#custom#var('grep', 'command', ['rg'])
silent! call denite#custom#var('grep', 'default_opts', ['--smart-case', '--vimgrep', '--no-heading'])
silent! call denite#custom#var('grep', 'recursive_opts', [])
silent! call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
silent! call denite#custom#var('grep', 'separator', ['--'])
silent! call denite#custom#var('grep', 'final_opts', [])
"silent! call denite#custom#source('grep', 'max_candidates', 30000)

nnoremap <Leader>d :Denite -highlight-matched-char=CursorLineNr 
nnoremap <C-p> :Denite file/old -ignorecase -highlight-matched-char=CursorLineNr<cr>
nnoremap f<C-p> :Denite file/rec -ignorecase -highlight-matched-char=CursorLineNr<cr>
nnoremap ff<C-p> :Denite  file/rec -path=.. -ignorecase -highlight-matched-char=CursorLineNr<cr>
nnoremap <Leader>a :Denite grep -highlight-matched-char=CursorLineNr -no-empty<cr>
nnoremap f<Leader>a :Denite grep -path=.. -highlight-matched-char=CursorLineNr -no-empty<cr>
nnoremap <Leader><Leader>a :DeniteCursorWord grep -highlight-matched-char=CursorLineNr -no-empty<cr>
nnoremap f<Leader><Leader>a :DeniteCursorWord grep -path=.. -highlight-matched-char=CursorLineNr -no-empty<cr>
"nnoremap c<C-p> :Denite -highlight-matched-char=CursorLineNr command<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nerdtree settings
"<F4> to show or hide nertree bar
map <F4> :NERDTreeToggle<CR>

let NERDTreeMapOpenSplit = 's'
let NERDTreeMapOpenVSplit = 'v'

"automatically open nerdtree when vim open a directory(2 lines below)
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

"close vim if nerdtree is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"customize the 'arrow' of nerdtree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
"let g:NERDTreeDirArrowExpandable = '+'
"let g:NERDTreeDirArrowCollapsible = '-'

let NERDTreeWinSize=27

" NERDTree File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
    exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
    exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('v', 'lightgreen', 'none', 'lightgreen', 'NONE')
call NERDTreeHighlightFile('sh', 'lightgreen', 'none', 'lightgreen', 'NONE')
call NERDTreeHighlightFile('py', 'yellow', 'none', 'yellow', 'NONE')
call NERDTreeHighlightFile('js', 'yellow', 'none', 'yellow', 'NONE')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'orange', 'NONE')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'orange', 'NONE')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'orange', 'NONE')
call NERDTreeHighlightFile('md', 'cyan', 'none', 'cyan', 'NONE')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', 'NONE')
call NERDTreeHighlightFile('cpp', 'cyan', 'none', 'cyan', 'NONE')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', 'NONE')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', 'NONE')
call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', 'NONE')
call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', 'NONE')
call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', 'NONE')
call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', 'NONE')
call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', 'NONE')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neosnippet settings
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
if has('win32')
    let g:neosnippet#snippets_directory = '$HOME/AppData/Local/nvim/snippets'
elseif has('unix')
    let g:neosnippet#snippets_directory = '$HOME/.nvim/snippets'
endif
imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NCM settings
    " tab for selection
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    " enter to start a newline
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
let g:cm_buffer_size_limit = 10000000
let g:cm_complete_start_delay = 0
let g:cm_complete_popup_delay = 0
let g:cm_matcher = {'module': 'cm_matchers.fuzzy_matcher', 'cases': 'smartcase'}
"NOTE: default g:cm_refresh_length = [[1,4],[7,3]]
"let g:cm_refresh_length = [[1, 2], [4, 2], [6, 10], [7, 3], [8, 2], [9, 4]]
let g:cm_refresh_length = [[7, 3],[9, 3]]
let g:cm_sources_override = {
            \ 'cm-tag': {'enable':0},
            \ 'cm-bufkeyword': {'cm_refresh_length':2},
            \ 'cm-otherbuf': {'cm_refresh_length':2},
            \ 'cm-filepath': {'cm_refresh_length':10}
            \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ncm2 settings
"autocmd BufEnter * call ncm2#enable_for_buffer()
"set completeopt=noinsert,menuone,noselect

"" use enter to close the menu and start a new line
"inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

"" Use <TAB> to select the popup menu:
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"let g:ncm2#popup_delay = 0
"let g:ncm2#matcher = 'abbrfuzzy'
"let g:ncm2#complete_length = [[1, 2],[9, 3]]

"if has('win32')
"    let g:ncm2_pyclang#library_path = 'C:\LLVM\bin\libclang.dll'
"endif
"autocmd FileType c,cpp nnoremap <buffer> gd :<c-u>call ncm2_pyclang#goto_declaration()<cr>
