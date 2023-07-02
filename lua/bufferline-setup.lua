local bufferline = require("bufferline")

--vim.cmd("set mousemoveevent")
bufferline.setup({
    options = {
        mode = "tabs",
        style_preset = bufferline.style_preset.default,
        numbers = function(opts)
            return string.format('%s', opts.ordinal)
        end,
        indicator = {
            icon = '▎',
            style = 'underline',
        },

        modified_icon = '',
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_buffer_icons = true,  -- whether to show the filetype icon
        color_icons = true, -- whether or not to add the filetype icon highlights

        diagnostic = false,

        tab_size = 1,
        truncate_names = false,
        --max_name_length = 12,
        --enforce_regular_tabs = true,

        show_tab_indicators = false,
        separator_style = "slant",
        show_duplicate_prefix = false, -- whether to show duplicate buffer prefix

        right_mouse_command = false,
    },
    highlights = {
        --tab_separator_selected = {
        --    --fg = '#111111',
        --    bg = '#888888',
        --},
        separator_selected = {
            --fg = '#111111',
            bg = '#888888'
        },
        buffer_selected = {
            fg = '#111111',
            bg = '#888888',
            bold = true,
            italic = false,
        },
        numbers_selected = {
            fg = '#111111',
            bg = '#888888',
            bold = true,
            italic = false,

        },
        modified_selected = {
            --fg = '#111111',
            bg = '#888888',
        },
        close_button_selected = {
            fg = '#111111',
            bg = '#888888',
        },
    }
})

