
local helpers = require('incline.helpers')
local incline_config = require('incline')
local has_devicons = package.loaded['nvim-web-devicons']

local devicons = has_devicons and require('nvim-web-devicons') or nil
local modified_icon = has_devicons and " " or "[+] "

local readonly_icon = has_devicons and " " or "[-] "

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
        local win_ft_color = focused and ft_color or "#424136"
        local filename_str =  ' ' .. filename .. ' '
            .. (non_modifiable and readonly_icon or '')
            .. (modified and modified_icon or '')
        local filename_fg = modified and '#e6db74' or (focused and '#ffffff' or '#8f908a')
        local filename_bg = focused and '#606060' or '#424136'
        local filename_gui = focused and 'bold,italic' or ''

        local indicator_bg = focused and '#ffffff' or '#424136'
        
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
