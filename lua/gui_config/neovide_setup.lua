vim.cmd('set title titlestring=Neovim')
-- vim.o.guifont = "DejaVuSansM Nerd Font Mono,SimHei:h12:#e-antialias"
vim.o.guifont = "CaskaydiaCove Nerd Font Mono,SimHei:h12:#e-antialias"
-- vim.o.guifont = "JetBrainsMono Nerd Font Mono,SimHei:h12:#e-antialias"
-- vim.o.guifont = "SauceCodePro Nerd Font Mono,SimHei:h12:#e-antialias"

-- NOTE: ligatures can be disabled in neovide config.toml,
-- with ["-calt"] font feature appended

-- TODO: use a UI select to choose different gui fonts

vim.opt.linespace = 0

-- animation
vim.g.neovide_cursor_animation_length = 0.1
vim.g.neovide_cursor_trail_size = 0.1
vim.g.neovide_scroll_animation_length = 0.1  -- scroll animation require 'multigrid' feature enabled
vim.g.neovide_refresh_rate = 60

-- display
vim.g.neovide_opacity = 1.0
vim.g.neovide_normal_opacity = 1.0

vim.g.neovide_hide_mouse_when_typing = true

vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5

vim.g.neovide_floating_corner_radius = 0

-- vim.g.neovide_title_background_color = string.format(
--     "%x",
--     vim.api.nvim_get_hl(0, {id=vim.api.nvim_get_hl_id_by_name("Normal")}).bg
-- )
-- vim.g.neovide_title_text_color = string.format(
--     "%x",
--     vim.api.nvim_get_hl(0, {id=vim.api.nvim_get_hl_id_by_name("Normal")}).fg
-- )

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

-- change the scaling
vim.g.neovide_scale_factor = 1.0
local scale_multipier = 1.1
local function change_scale_factor(delta)
   vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(scale_multipier)
    vim.notify("scaling to " .. tostring(vim.g.neovide_scale_factor))
end)
vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / scale_multipier)
    vim.notify("scaling to " .. tostring(vim.g.neovide_scale_factor))
end)

local function toggle_full_screen()
    if vim.g.neovide_fullscreen then
        vim.g.neovide_fullscreen = false
    else
        vim.g.neovide_fullscreen = true
    end
end
vim.keymap.set('n', '<F11>', function() toggle_full_screen() end)
vim.api.nvim_create_user_command("NeovideToggleFullscreen",
    function() toggle_full_screen() end,
    {desc = "Toglle Fullscreen in Neovide gui",}
)


