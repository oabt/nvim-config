vim.cmd('set title titlestring=Neovim')
vim.o.guifont = "DejaVuSansM Nerd Font Mono:h12:#e-antialias"
vim.opt.linespace = 0
vim.g.neovide_cursor_animation_length = 0.06
vim.g.neovide_cursor_trail_size = 0.1
vim.g.neovide_scroll_animation_length = 0.3

vim.g.neovide_scale_factor = 1.0
--local change_scale_factor = function(delta)
--    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
--end
--vim.keymap.set("n", "<C-<Up>>", function()
--    change_scale_factor(1.25)
--end)
--vim.keymap.set("n", "<C-<Down>>", function()
--  change_scale_factor(1/1.25)
--end)

local function toggle_full_screen()
    if vim.g.neovide_fullscreen then
        vim.g.neovide_fullscreen = false
    else
        vim.g.neovide_fullscreen = true
    end
end
vim.keymap.set('n', '<F11>', function() toggle_full_screen() end)

