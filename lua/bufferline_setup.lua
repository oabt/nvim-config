        -- {"akinsho/bufferline.nvim",
        --     event = "VeryLazy",
        --     dependencies = {"nvim-tree/nvim-web-devicons"},
        --     version = "*",
        --     config = function() require('bufferline_setup') end,
        -- },

local bufferline = require("bufferline")

local has_devicons = package.loaded['nvim-web-devicons']

local function oabt_tab_style()
    if has_devicons then
        return "slant"
    else
        return "thin"
    end
end

local function oabt_modified_icon()
    if has_devicons then
        return ''
    else
        return '[+]'
    end
end

local function oabt_close_icon()
    if has_devicons then
        return '󱎘'
    else
        return '[X]'
    end
end

--vim.cmd("set mousemoveevent")
bufferline.setup({
    options = {
        mode = "tabs",
        style_preset = bufferline.style_preset.default,
        numbers = function(opts)
            return string.format('%s', opts.ordinal)
        end,
        --indicator = {
        --    icon = '▎',
        --    style = 'underline',
        --},

        modified_icon = oabt_modified_icon(),
        show_buffer_close_icons = true,
        buffer_close_icon =  oabt_close_icon(),

        show_close_icon = false,
        show_buffer_icons = true,  -- whether to show the filetype icon
        color_icons = true, -- whether or not to add the filetype icon highlights

        diagnostic = false,

        tab_size = 1,
        truncate_names = false,
        --max_name_length = 12,
        --enforce_regular_tabs = true,

        show_tab_indicators = false,
        separator_style = oabt_tab_style(),
        show_duplicate_prefix = false, -- whether to show duplicate buffer prefix

        right_mouse_command = false,
    },
    highlights = {
        fill = {
            bg = '#000000',
        },

        separator = {  -- separator of unselected tabs
            fg = '#000000',  -- same as the 'fill'
            bg = '#111111'
        },
        background = {
            bg = '#111111',
        },
        numbers = {
            bg = '#111111',
        },
        modified = {
            bg = '#111111',
        },
        close_button = {
            bg = '#111111',
        },

        --tab_separator_selected = {
        --    --fg = '#FFFFFF',
        --    bg = {
        --    attribute = "bg",
        --    highlight = "Normal",
        --    },
        --},
        separator_selected = {
            fg = '#000000',  -- same as the 'fill'
            bg = {
                attribute = "bg",
                highlight = "Normal",
            },
        },
        buffer_selected = {
            fg = '#FFFFFF',
            bg = {
                attribute = "bg",
                highlight = "Normal",
            },
            bold = true,
            italic = true,
        },
        numbers_selected = {
            fg = '#FFFFFF',
            bg = {
                attribute = "bg",
                highlight = "Normal",
            },
            bold = true,
            italic = true,
        },
        modified_selected = {
            --fg = '#FFFFFF',
            bg = {
                attribute = "bg",
                highlight = "Normal",
            },
        },
        close_button_selected = {
            fg = {
                attribute = "fg",
                highlight = "Error",
            },
            bg = {
                attribute = "bg",
                highlight = "Normal",
            },
        },
        indicator_selected = {
            bg = {
                attribute = "bg",
                highlight = "Normal",
            },
        },
    }
})

