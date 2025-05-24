local style_configs = {
    zindex = 10,
    height = 0,
    width = 0,
    bo = {
        bufhidden = "wipe",
        buftype = "nofile",
        buflisted = false,
        filetype = "snacks_dashboard",
        swapfile = false,
        undofile = false,
    },
    wo = {
        colorcolumn = "",
        cursorcolumn = false,
        cursorline = false,
        foldmethod = "manual",
        list = false,
        number = false,
        relativenumber = false,
        sidescrolloff = 0,
        signcolumn = "no",
        spell = false,
        statuscolumn = "",
        statusline = "",
        winbar = "",

        -- do not set hl here
        -- winhighlight = "Normal:SnacksDashboardNormal,NormalFloat:SnacksDashboardNormal",
        winhighlight = "",

        wrap = false,
    },
}

return style_configs
