
local helpers = require('incline.helpers')
local incline_config = require('incline')
local has_devicons = package.loaded['nvim-web-devicons']

local devicons = has_devicons and require('nvim-web-devicons') or nil
local modified_icon = has_devicons and " " or "[+] "

local readonly_icon = has_devicons and " " or "[-] "

local modified_fg = "#e6db74"
local active_fg = "#ffffff"
local inactive_fg = "#8f908a"
local active_bg = "#606060"
local inactive_bg = "#424136"

incline_config.setup {
    window = {
        padding = 0,
        margin = { horizontal = 0 },
        zindex = 20,
        placement = {
            vertical = 'top',
            horizontal = 'right',
        },
        winhighlight = {
            -- active = {
            --     Normal = 'InclineNormal',
            -- },
            -- inactive = {
            --     Normal = 'None',
            -- }
        },
    },
    ignore = {
        -- set to false to show unlisted buffers
        unlisted_buffers = false,

        -- show on the buffers that:
        -- 1. have valid buffer name;
        -- 2. are shown in at least one window (may be redundant);
        buftypes = function(bufnr, buftype)
            local buf_info = vim.fn.getbufinfo(bufnr)[1]
            if buf_info['name'] ~= '' and #buf_info['windows'] > 0 then
                return false
            else
                return true
            end
        end,
        filetypes = {
            "incline",
            "neo-tree",
            "startify",
            "dapui_scopes", "dapui_watches", "dapui_console", "dap-repl", "dapui_breakpoints", "dapui_stacks",
            "qf",
        },
    },
    render = function(props)
        -- local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')

        -- filename with relative path
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':.')

        local ft_icon, ft_color
        if has_devicons then
            ft_icon, ft_color = devicons.get_icon_color(filename)
            if ft_icon == nil then
                ft_icon, ft_color = devicons.get_icon_color_by_filetype(vim.bo[props.buf].filetype)
            end
            if ft_icon == nil then
                ft_icon, ft_color = '', '#6d8086' 
            end
        else
            ft_icon = nil
        end

        local focused = props.focused
        local modified = vim.bo[props.buf].modified
        local non_modifiable = (not vim.bo[props.buf].modifiable) or vim.bo[props.buf].readonly

        local ft_str = ft_icon and (' ' .. ft_icon .. ' ') or ''
        local win_ft_color = focused and ft_color or inactive_bg

        local filename_str =  ' ' .. filename .. ' '
            .. (non_modifiable and readonly_icon or '')
            .. (modified and modified_icon or '')
        local filename_fg = modified and modified_fg or (focused and active_fg or inactive_fg)
        local filename_bg = focused and active_bg or inactive_bg
        local filename_gui = focused and 'bold,italic' or ''

        local indicator_bg = focused and active_fg or inactive_bg
        
        return {
            -- file icon
            { ft_str,
                guifg = helpers.contrast_color(win_ft_color),
                guibg = win_ft_color,
                blend = focused and 0 or 30,
            },

            -- filename with modified mark
            { filename_str,
                guifg = filename_fg,
                guibg = filename_bg,
                blend = focused and 0 or 30,
            },

            {' ',
                guibg = indicator_bg,
            }

        }
    end,
}

