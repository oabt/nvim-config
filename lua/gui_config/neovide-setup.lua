vim.cmd('set title titlestring=Neovim')
vim.o.guifont = "DejaVuSansM Nerd Font Mono:h12:#e-antialias"
vim.opt.linespace = 0

-- animation
vim.g.neovide_cursor_animation_length = 0.06
vim.g.neovide_cursor_trail_size = 0.1
vim.g.neovide_scroll_animation_length = 0.3  -- scroll animation require 'multigrid' feature enabled
vim.g.neovide_refresh_rate = 60

-- display
vim.g.neovide_transparency = 1.0

vim.g.neovide_hide_mouse_when_typing = true

-- only enable IME in insert and cmdline mode
local function set_ime(args)
    if args.event:match("Enter$") then
        vim.g.neovide_input_ime = true
    else
        vim.g.neovide_input_ime = false
    end
end

local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = ime_input,
    pattern = "*",
    callback = set_ime
})

vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
    group = ime_input,
    pattern = "[/\\?]",
    callback = set_ime
})

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

