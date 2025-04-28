        -- {'nanozuki/tabby.nvim',
        --     event = 'VeryLazy', -- if you want lazy load, see below
        --     dependencies = 'nvim-tree/nvim-web-devicons',
        --     config = function() require('tabby_setup') end,
        -- },

local tabby = require('tabby')

local has_devicons = package.loaded['nvim-web-devicons']
local devicons = has_devicons and require('nvim-web-devicons') or nil

local tabline_symbols = {
    left_sep = has_devicons and '' or '',
    right_sep = has_devicons and '' or ' ',
    close_icon = has_devicons and '󱎘' or '[x]',
    modified_icon = has_devicons and '' or '[+]',
}

-- get the hex color of exiting hl_group
local function get_hex(hlgroup_name, attr) -- reference nvim-cokeline
    local hlgroup_ID = vim.fn.synIDtrans(vim.fn.hlID(hlgroup_name))
    local hex = vim.fn.synIDattr(hlgroup_ID, attr)
    return hex ~= "" and hex or "NONE"
end

-- return the filename, ft_icon, and ft_color
local function devicons_symbol(cur_buf)
    local orig_buf_name = vim.api.nvim_buf_get_name(cur_buf)
    local buf_name = vim.fn.fnamemodify(orig_buf_name, ":~:.")
    local file_name = vim.fn.fnamemodify(orig_buf_name, ":t")

    local ft_icon, ft_color
    if has_devicons and devicons then
        ft_icon, ft_color = devicons.get_icon_color(buf_name)
        if ft_icon == nil then
            ft_icon, ft_color = devicons.get_icon_color_by_filetype(vim.bo[cur_buf].filetype)
        end
        if ft_icon == nil then
            ft_icon, ft_color = '', '#6d8086'
        end
    else
        return file_name, nil, nil -- only return filename if devicons is not enabled
    end
    return file_name, ft_icon, ft_color
end

-- return true if the bufs in tab have unmodifed changes
local function tab_modified(tabid)
    local tab_info = vim.fn.gettabinfo(tabid)[1]
    if tab_info == nil then -- tab is closed
        return false
    end

    for _, win in ipairs(tab_info.windows) do
        local bufnr = vim.api.nvim_win_get_buf(win)
        local buf_modified = vim.api.nvim_get_option_value("modified", {buf=bufnr})
        if buf_modified then
            return true
        end
    end
    return false
end

local function get_min_max_tabid(line)
    local tab_width_list = {}
    local center_tab_width = 0
    local center_id = 0

    for _, tab in ipairs(line.tabs().tabs) do
        local cur_buf = tab.current_win().buf().id
        local file_name, _, _ = devicons_symbol(cur_buf)
        local node_width = #file_name
        if (has_devicons) then
            node_width = node_width + 10
        else
            node_width = node_width + 8
        end
        tab_width_list[tab.id] = node_width
        if tab.is_current() then
            center_id = tab.id
            center_tab_width = node_width
        end
    end

    local min_tabid = center_id
    local max_tabid = center_id
    local rest_col = vim.o.columns - center_tab_width
    for expand = 1, vim.fn.tabpagenr('$') do
        local left_bounded = false
        local right_bounded = false
        if center_id - expand > 0 and rest_col - tab_width_list[center_id - expand] > 0 then
            min_tabid = center_id - expand
            rest_col = rest_col - tab_width_list[min_tabid]
        else
            left_bounded = true
        end

        if center_id + expand <= vim.fn.tabpagenr('$') and rest_col + tab_width_list[center_id + expand] > 0 then
            max_tabid = center_id + expand
            rest_col = rest_col - tab_width_list[max_tabid]
        else
            right_bounded = true
        end

        if left_bounded and right_bounded then
            break
        end
    end
    return max_tabid, min_tabid
end


tabby.setup({

    line = function(line)

        local max_tabid, min_tabid = get_min_max_tabid(line)

        return {


            line.tabs().foreach(function(tab)

                local hl = tab.is_current() and 'TabbyLineSel' or 'TabbyLine'

                -- only render the tabs around the current tab
                if tab.number() > max_tabid or tab.number() < min_tabid then
                    -- do not render the tabs that are far from the current tab
                    if tab.number() == max_tabid + 1 or tab.number() == min_tabid - 1 then
                        return ".."
                    end
                    return {}
                end

                local truncate_point = (tab.number() == max_tabid) and line.truncate_point() or ""

                local cur_buf = tab.current_win().buf().id

                local file_name, ft_icon, ft_color = devicons_symbol(cur_buf)

                local close_modified = {}
                if tab_modified(tab.number()) then
                    close_modified = {tabline_symbols.modified_icon,
                        hl=tab.is_current() and 'String'
                        or {fg=get_hex('String', 'fg'), bg=get_hex('TabbyLine', 'bg')}
                    }
                else
                    close_modified = {tab.close_btn(tabline_symbols.close_icon),
                        hl=tab.is_current() and 'Error' or 'TabbyLine'
                    }
                end

                return {
                    line.sep(tabline_symbols.left_sep, hl, 'TabbyLineFill'),

                    tab.number(), -- tab number

                    {ft_icon, -- devicons of the tab
                        hl={fg=ft_color, bg=tab.is_current()
                            and get_hex('TabbyLineSel', 'bg')
                            or get_hex('TabbyLine', 'bg')
                        }
                    },

                    -- tab.name(),
                    -- tab.current_win().buf_name(),
                    file_name, -- name of the tab

                    close_modified, -- close or modified symbol

                    truncate_point,

                    line.sep(tabline_symbols.right_sep, hl, 'TabbyLineFill'),

                    hl = hl,
                    margin = ' ',
                }
            end),

            hl = 'TabbyLineFill',
        }
    end, -- end of 'line option'

    option = {
        buf_name ={ mode = 'unique' }
    }, -- setup modules' option,

})

