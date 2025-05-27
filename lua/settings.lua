-- basic settings of neovim: import from vim-legacy
local opt = vim.opt
local g = vim.g

g.enable_devicons = true

vim.cmd([[syntax enable]]) -- syntax enable is default in neovim
opt.number = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.belloff = "all"

vim.cmd[[
filetype plugin on
filetype indent on 
filetype plugin indent on
]]

opt.timeoutlen = 400
opt.updatetime = 400
opt.autoindent = true
opt.cindent = true
opt.smartindent = true
opt.completeopt = "longest,menu"
opt.wildmenu = true
opt.viminfo = "'250,<50,s10,h,rA:,rB:"

opt.showtabline = 2
opt.laststatus = 3
opt.undodir = vim.env.HOME .. "/.nvim/undo"
opt.termguicolors = true

opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.inccommand = "nosplit"

opt.mouse = "nv"  --enable mouse in Normal Mode and Visual Mode
opt.selection = "exclusive"
opt.selectmode = "" --unset the selectmode
opt.showcmd = true
opt.scrolloff = 4  --left 4 lines below/above when scrolling below/above
opt.cursorline = true

opt.clipboard:append('unnamedplus')

opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.foldmethod = "indent"
opt.foldlevelstart = 99

opt.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50'
..',a:blinkwait1000-blinkoff500-blinkon500-Cursor/lCursor'
..',sm:block-blinkwait175-blinkoff150-blinkon175'

opt.wrap = false

