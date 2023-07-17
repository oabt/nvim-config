-- neovide gui config
if vim.g.neovide then
    require('gui_config.neovide-setup')
end

-- goneovim gui config
if vim.g.gonvim_running then
    require('gui_config.goneovim-setup')
end

