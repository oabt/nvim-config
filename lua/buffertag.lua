local M = {}

local has_devicons = package.loaded['nvim-web-devicons']
local devicons = has_devicons and require('nvim-web-devicons') or nil

local function get_hex(hlgroup_name, attr) -- reference nvim-cokeline
    local hlgroup_ID = vim.fn.synIDtrans(vim.fn.hlID(hlgroup_name))
    local hex = vim.fn.synIDattr(hlgroup_ID, attr)
    return hex ~= "" and hex or "NONE"
end

local default_config = {
    border = "none",
    zindex = 10,
    limit_width = false,
    modified_icon = has_devicons and " " or "[+] ",
    readonly_icon = has_devicons and " " or "[-] ",
    ignored_buftype = {},
    ignored_filetype = {},
}

local default_hl = {
    modified_fg = get_hex('String', 'fg'),
    active_fg = "#ffffff",
    inactive_fg = get_hex('Conceal', 'fg'),
    active_bg = "#606060",
    inactive_bg = get_hex('NormalFloat', 'bg'),
}

local focused_hl = {
    fg = default_hl.active_fg,
    bg = default_hl.active_bg,
    bold = true,
    italic = true,
    underline = true,
}
local focused_modified_hl = {
    fg = default_hl.modified_fg,
    bg = default_hl.active_bg,
    bold = true,
    italic = true,
    underline = true,
}
local unfocused_hl = {
    fg = default_hl.inactive_fg,
    bg = default_hl.inactive_bg,
    blend = 30,
}
local unfocused_modified_hl = {
    fg = default_hl.modified_fg,
    bg = default_hl.inactive_bg,
    italic = true,
    blend = 30,
}

local bt_ns = vim.api.nvim_create_namespace("BufferTag_NS")
vim.api.nvim_set_hl(bt_ns, 'BTActive', focused_hl)
vim.api.nvim_set_hl(bt_ns, 'BTActiveM', focused_modified_hl)
vim.api.nvim_set_hl(bt_ns, 'BTInactive', unfocused_hl)
vim.api.nvim_set_hl(bt_ns, 'BTInactiveM', unfocused_modified_hl)

-- @oabt: clear the 'Search' for the buffertag (namespace: bt_ns)
vim.api.nvim_set_hl(bt_ns, "Search", {})

local function tableContains(tab, value)
    for i = 1, #tab do
        if tab[i] == value then
            return true
        end
    end
    return false
end

-- holds any currently open {float_win, parent_win} paris displaying buffer tags
local float_wins = {}

local function decorated_bufname(cur_buf)
    local buf_name = vim.api.nvim_buf_get_name(cur_buf)
    buf_name = vim.fn.fnamemodify(buf_name, ":~:.")

    local buf_modified = vim.api.nvim_get_option_value("modified", {buf=cur_buf})
    local buf_readonly = vim.api.nvim_get_option_value("readonly", {buf=cur_buf}) or
        (not vim.api.nvim_get_option_value("modifiable", {buf=cur_buf}))
    local buftype = vim.api.nvim_get_option_value("buftype", {buf=cur_buf})

    if buftype == 'terminal' then
        local term_filename = {}
        -- split the filename by ":"
        for str in string.gmatch(buf_name, "([^" .. ":" .. "]+)") do
            table.insert(term_filename, str)
        end
        -- use only the firt section ("term") and the last section (command)
        -- as the new filename for terminal
        buf_name = term_filename[1] .. ":" .. term_filename[#term_filename]
    end

    buf_name = " " .. buf_name .. " "
    if buf_modified then
        buf_name = buf_name .. default_config.modified_icon
    elseif buf_readonly then
        buf_name = buf_name .. default_config.readonly_icon
    end

    return buf_name, buf_modified
end

local function devicons_symbol(cur_buf)
    local buf_name = vim.api.nvim_buf_get_name(cur_buf)
    buf_name = vim.fn.fnamemodify(buf_name, ":~:.")

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
        return nil, nil, nil
        -- ft_icon = ""
    end

    -- from incline.nvim
    local contrast_color
    local dark = '#000000'
    local light = '#ffffff'
    local threshold = 0.179
    local ft_rgb = ft_color:gsub('#', ''):lower()
    local r, g, b =
        tonumber(ft_rgb:sub(1, 2), 16) / 255,
        tonumber(ft_rgb:sub(3, 4), 16) / 255,
        tonumber(ft_rgb:sub(5, 6), 16) / 255

    local function adjust(channel)
        if channel <= 0.03928 then
            return channel / 12.92
        else
            return ((channel + 0.055) / 1.055) ^ 2.4
        end
    end
    r, g, b = adjust(r), adjust(g), adjust(b)
    local relative_luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
    if relative_luminance > threshold then
        contrast_color = dark
    else
        contrast_color = light
    end

    return ft_icon, ft_color, contrast_color
end

local function create_tag_float(parent_win, focused, existed_float_win)
    local cur_buf = vim.api.nvim_win_get_buf(parent_win)
    local buf_name, buf_modified = decorated_bufname(cur_buf)
    local ft_icon, ft_color, contrast_color = devicons_symbol(cur_buf)

    -- couldn't determine a buffer name, for whatever reason, just return and dont
    -- tag the buffer.
    if #buf_name <= 0 then
        return
    end

    local icon_header = ''
    if has_devicons and focused then
        icon_header = ' ' .. ft_icon .. ' '
    elseif has_devicons then
        icon_header = ' ' .. ft_icon
    end
    buf_name = icon_header .. buf_name

    local buftype = vim.api.nvim_get_option_value("buftype", {buf=cur_buf})
    local filetype = vim.api.nvim_get_option_value("filetype", {buf=cur_buf})
    if  tableContains(default_config.ignored_buftype, buftype) or
        tableContains(default_config.ignored_filetype, filetype) then
        return
    end

    local popup_text = buf_name
    -- By default, the popup width is the same as the length of the buffer text we want to show.
    -- @oabt: do not use #buf_name, use vim.api.nvim_strwidth
    -- because '#' is the number of bytes instead of the number of chars
    local popup_width = vim.api.nvim_strwidth(buf_name)

    local window_width = vim.api.nvim_win_get_width(parent_win)
    -- Subtract 5 here to give the window a bit of padding - otherwise it can
    -- look a bit squashed as technically the text fits, but it's right up to
    -- the very edge of the pane and doesn't look great
    local window_width_with_padding = window_width - 5;

    if default_config.limit_width and popup_width > window_width_with_padding then
        popup_width = window_width_with_padding
        -- Take the last X characters of the buf_name, where X is the available width.
        -- e.g. if the name is foo/bar/baz.js, and the width is 6, this will return baz.js
        popup_text = string.sub(popup_text, #buf_name - popup_width + 1, #buf_name)
    end

    if popup_width >= vim.api.nvim_win_get_width(0) or popup_width < 0 then
        -- do not paint buffer tag
        return
    end

    local popup_conf = {
        relative = "win",
        anchor = "NE",
        win = parent_win,
        width = popup_width,
        height = 1,
        focusable = false,
        zindex = default_config.zindex,
        style = "minimal",
        border = "none",
        row = 0,
        col = vim.api.nvim_win_get_width(parent_win),
        title = vim.api.nvim_get_option_value("filetype", {buf=cur_buf}),
    }

    local float_win = existed_float_win
    local float_buf = nil
    if existed_float_win == nil then
        float_buf = vim.api.nvim_create_buf(false, true)
        if float_buf == 0 then
            vim.api.nvim_echo({"details_popup: could not create details buffer"}, true, {err=true})
            return nil
        end
    else
        -- get the bufnr according to the existed_float_win
       float_buf = vim.api.nvim_win_get_buf(existed_float_win)
    end
    vim.api.nvim_set_option_value('bufhidden', 'hide', {buf=float_buf})
    vim.api.nvim_set_option_value('filetype', 'buffertag', {buf=float_buf})
    vim.api.nvim_set_option_value('modifiable', true, {buf=float_buf})
    vim.api.nvim_buf_set_lines(float_buf, 0, 1, false, {popup_text})
    vim.api.nvim_set_option_value('modifiable', false, {buf=float_buf})

    if existed_float_win == nil then
        -- create a new floating window
        float_win = vim.api.nvim_open_win(float_buf, false, popup_conf)
        table.insert(float_wins, {float_win, parent_win})
    else
        -- update the existed_float_win
        vim.api.nvim_win_set_config(existed_float_win, popup_conf)
    end

    -- @oabt: set the namespace for the float_win
    vim.api.nvim_win_set_hl_ns(float_win, bt_ns)

    local filename_col = 0
    if has_devicons and focused then
        -- @oabt: set the hl of the filetype icon
        filename_col = #icon_header
        vim.api.nvim_set_hl(bt_ns, "BTIcon", {fg = contrast_color, bg = ft_color})

        vim.hl.range(float_buf, bt_ns, 'BTIcon', {0, 0}, {0, filename_col})
        -- -- Deprecated in nvim-0.11
        -- vim.api.nvim_buf_add_highlight(float_buf, bt_ns, 'BTIcon', 0, 0, filename_col)

    end

    if focused and buf_modified then
        vim.hl.range(float_buf, bt_ns, 'BTActiveM', {0, filename_col}, {0, -1})
        -- -- Deprecated in nvim-0.11
        -- vim.api.nvim_buf_add_highlight(float_buf, bt_ns, 'BTActiveM', 0, filename_col, -1)
    elseif focused and (not buf_modified) then
        vim.hl.range(float_buf, bt_ns, 'BTActive', {0, filename_col}, {0, -1})
        -- -- Deprecated in nvim-0.11
        -- vim.api.nvim_buf_add_highlight(float_buf, bt_ns, 'BTActive', 0, filename_col, -1)
    elseif (not focused) and buf_modified then
        vim.hl.range(float_buf, bt_ns, 'BTInactiveM', {0, filename_col}, {0, -1})
        -- -- Deprecated in nvim-0.11
        -- vim.api.nvim_buf_add_highlight(float_buf, bt_ns, 'BTInactiveM', 0, filename_col, -1)
    else
        vim.hl.range(float_buf, bt_ns, 'BTInactive', {0, filename_col}, {0, -1})
        -- -- Deprecated in nvim-0.11
        -- vim.api.nvim_buf_add_highlight(float_buf, bt_ns, 'BTInactive', 0, filename_col, -1)
    end
end


function M.display_buffertags()
    local wins_to_tag = {}
    local win_list = vim.api.nvim_tabpage_list_wins(0)
    for _, win in ipairs(win_list) do
        local bufnr = vim.api.nvim_win_get_buf(win)
        local buf_info = vim.fn.getbufinfo(bufnr)
        -- print(vim.inspect(buf_info))

        -- @oabt: avoid nested (buffer tag on a buffer tag)
        if vim.api.nvim_get_option_value("filetype", {buf=bufnr}) ~= 'buffertag' and
            buf_info[1]['listed'] == 1 then
            table.insert(wins_to_tag, win)
        end

        -- 'help' need buffertag
        if vim.bo[bufnr].buftype == 'help' then
            table.insert(wins_to_tag, win)
        end
    end

    -- @oabt: close the float win belongs to the invisible windows (not shown in this tab)
    for idx, floats in ipairs(float_wins) do
        if (not tableContains(wins_to_tag, floats[2])) then
            if vim.api.nvim_win_is_valid(floats[1]) then
                local del_buf = vim.api.nvim_win_get_buf(floats[1])
                vim.api.nvim_win_close(floats[1], true)
                vim.api.nvim_buf_delete(del_buf, {force=true})
            end
            table.remove(float_wins, idx)
        end
    end

    local cur_win = vim.api.nvim_get_current_win()
    for _, win in ipairs(wins_to_tag) do -- @oabt: create float_win for windows to be tagged
        -- @oabt: check whether a float window already exists to reuse for the window
        local existed_float_win = nil
        for _, float_pair in ipairs(float_wins) do
            if win == float_pair[2] and tableContains(win_list, float_pair[1]) then
                existed_float_win = float_pair[1]
                break
            end
        end
        create_tag_float(win, win==cur_win, existed_float_win)
    end
end

function M.remove_buffertags()
    for _, floats in ipairs(float_wins) do
        if vim.api.nvim_win_is_valid(floats[1]) then
            local del_buf = vim.api.nvim_win_get_buf(floats[1])
            vim.api.nvim_win_close(floats[1], true)
            vim.api.nvim_buf_delete(del_buf, {force=true})
        end
    end
    float_wins = {}
end

local au_id = nil

local enabled = false

local bt_augroup = vim.api.nvim_create_augroup("bt_augroup", { clear = true })

function M.enable()
    au_id = vim.api.nvim_create_autocmd(
        {
            "WinEnter",
            "BufEnter",
            "CursorHold",
            "CursorHoldI",
            'WinScrolled', -- VimResized detects changes in the overall terminal size
        },
        {
            callback = M.display_buffertags,
            group = bt_augroup,
        }
    )
    enabled = true
    -- run it so an initial window move isn't necessary
    M.display_buffertags()
end

function M.disable()
    if au_id ~= nil then
        vim.api.nvim_del_autocmd(au_id)
    end
    enabled = false
    M.remove_buffertags()
end

function M.toggle()
    if enabled then
        M.disable()
    else
        M.enable()
    end
end

function M.setup(config)
    if config ~= nil then
        for k, v in pairs(config) do
            default_config[k] = v
        end
    end

    vim.api.nvim_create_user_command("BuftagToggle", M.toggle, {
        desc = "Toggle the Buffertag feature on and off."
    })

    -- toggle it on.
    M.toggle()
end

return M
