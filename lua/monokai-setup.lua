monokai = require('ofirkai')

local oabt_scheme = {
    -- override
    background = '#2D2E28',
    ui_bg = '#2D2E28',
    winbar_bg = '#2D2E28',
    comment_fg = '#75715E',
    cursor_line_bg = '#424136',
    pmenu_bg = '#424136',
    pmenu_sel_bg = '#808080',
    search_bg = '#D7AF5F',
    visual_bg = '#595656',
    cursor_line_bg = '#424136',
    vert_split_fg = '#444444',
    telescope_bg = '#2D2E28',
    telescope_prompt = '#2D2E28',

    -- customized
    oabt_search_yellow = '#D7AF5F',
    oabt_macro = '#C4BE89',
}

local oabt_hl_group = {
    -- ordinay hl groups
    LineNr = {
        fg='#6c6c6c', bg=oabt_scheme.background,
    },
    MatchParen = {
        fg='#000000', bg='#FD971F', sp='#FD971F', bold=true,
    },
    Search = {
        fg = oabt_scheme.background,
        bg = oabt_scheme.oabt_search_yellow,
    },
    IncSearch = {
        fg = oabt_scheme.background,
        bg = oabt_scheme.oabt_search_yellow,
    },
    Folded = {
        bg = oabt_scheme.background,
    },

    StorageClass = {
        fg = monokai.scheme.aqua,
    },
    Special = {
        fg = monokai.scheme.aqua,
        italic = true,
    },
    Macro = {
        fg = oabt_scheme.oabt_macro,
        italic = true,
    },
    Identifier = {
        fg = monokai.scheme.orange,
    },
    Type = {
        fg = monokai.scheme.aqua,
        italic = true,
    },

    NormalFloat = {
        bg = oabt_scheme.pmenu_bg,
    },
    FloatBorder = {
        fg = monokai.scheme.white,
        bg = oabt_scheme.ui_bg,
    },

    -- hl groups specified for telescope.nvim
    TelescopeBorder = {
        fg = monokai.scheme.white,
    },
    TelescopePromptBorder = {
        fg = monokai.scheme.white,
    },
    TelescopeResultsTitle = {
        fg = monokai.scheme.white,
    },

    -- hl groups specified for Gitsigns
    GitSignsAdd = { fg = '#87ff5f', ctermfg = 119,},
    GitSignsDelete = { fg = '#d75f5f', ctermfg = 167,},
    GitSignsChange = { fg = '#ffff5f', ctermfg = 227,},

    LuaLineDiffAdd = {link = 'GitSignsAdd'},
    LuaLineDiffDelete = {link = 'GitSignsDelete'},
    LuaLineDiffChange = {link = 'GitSignsChange'},

    -- hl groups specified for nvim-tree
    NvimTreeIndentMarker = {link = 'NonText'},

}

monokai.setup({
    scheme = oabt_scheme,
    custom_hlgroups = oabt_hl_group,
})

