vim.cmd([[runtime vim-legacy.vim]])

-------------------------------- setting up lua plugins
require('nvim-cmp-setup')
--TODO: dense-analysis/ale may needless
require('lspconfig-setup')
--subistitution of auto-pairs
require('nvim-autopairs-setup')
--subistitution of vim-surround
require('nvim-surround-setup')
--subistitution of vim-easymotion
require('hop-setup')
--subistitution of denite
require('telescope-setup')
--subistitution of nerdcommenter
--require('comment-setup')
--subistitution of defx
require('nvim-tree-setup')
--subistitution of vim-signify
require('gitsigns-setup')
--subistitution of lightline statusline
require('lualine-setup')
-- subistitution of lightline tabline
require('bufferline-setup')

if vim.g.neovide then
    require('neovide-setup')
end

--if exists("g:neovide")
--  lua require('neovide-setup')
--endif

