-- neovide gui config
if vim.g.neovide then
    require('gui_config.neovide_setup')
end

-- goneovim gui config
if vim.g.gonvim_running then
    require('gui_config.goneovim-setup')
end

-- neoray gui config
if vim.g.neoray then
    require('gui_config.neoray_setup')
end

