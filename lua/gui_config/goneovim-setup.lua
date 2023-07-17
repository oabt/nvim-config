-- the detail config of goneovim is located at $HOME/.config/goneovim/settings.toml
-- some typical settings to be set
--      RestoreWindowGeometry = true
--      FontFamily = "DejaVuSansM Nerd Font Mono"
--      FontSize = 12
--      ModeEnablingIME = ["insert", "cmdline_normal"] 
--      HideMouseWhenTyping = true
--      SmoothScroll = true
--      SmoothMove = true
--      Duration = 100

-- toggle fullscreen in goneovim
local is_fullscreen = false
local function toggle_full_screen()
    if is_fullscreen then
        is_fullscreen = false
        vim.cmd("GonvimFullscreen 0")
    else
        is_fullscreen = true
        vim.cmd("GonvimFullscreen 1")
    end
    --TODO: not fully supported in goneovim
end
vim.keymap.set('n', '<F11>', function() toggle_full_screen() end)

