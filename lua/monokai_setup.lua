local monokai = require('ofirkai')

local oabt_scheme = {
    -- override
    background = '#2D2E28',
    ui_bg = '#2D2E28',
    winbar_bg = '#2D2E28',
    sidebar_bg = '#2D2E28',
    comment_fg = '#75715E',
    cursor_line_bg = '#424136',
    pmenu_bg = '#424136',
    pmenu_sel_bg = '#808080',
    search_bg = '#D7AF5F',
    visual_bg = '#595656',
    vert_split_fg = '#444444',
    telescope_bg = '#2D2E28',
    telescope_prompt = '#2D2E28',

    -- customized
    oabt_dark_bg = '#242520',
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
    PmenuSel = {
        fg = oabt_scheme.background,
        bg = oabt_scheme.search_bg,
        bold = true,
    },
    CursorColumn = { link = 'CursorLine' },

    -- terminal winhighlight: set in auto_commands.lua
    TermNormal = {
        fg = monokai.scheme.white,
        bg = oabt_scheme.oabt_dark_bg,
    },
    TermLineNr = {
        fg = '#6c6c6c',
        bg = oabt_scheme.oabt_dark_bg,
    },
    TermCursorLineNr = {
        fg = monokai.scheme.yellow,
        bg = oabt_scheme.oabt_dark_bg,
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
    TelescopeMatching = {
        fg = monokai.scheme.orange,
        underline = true,
    },

    SnacksPicker = {
        link = "Normal"
    },
    SnacksPickerMatch = {
        link = "TelescopeMatching",
    },
    SnacksPickerListCursorLine = {
        link = "SnacksPickerCursorLine",
    },
    SnacksIndentScope = {
        link = "Comment",
    },

    -- nvim-cmp hl groups
    CmpItemAbbrMatch = {
        fg = monokai.scheme.orange,
    },
    CmpItemAbbrMatchFuzzy = {
        fg = monokai.scheme.orange,
    },
    CmpItemKindFunction = {
        fg = monokai.scheme.green,
    },
    CmpItemKindMethod = {
        fg = monokai.scheme.green,
    },
    CmpItemKindField = {
        fg = monokai.scheme.aqua,
    },

    -- blink-cmp hl groups
    BlinkCmpMenuBorder = {
        link = 'FloatBorder',
    },
    BlinkCmpKindKeyword = {
        link ='CmpItemKindKeyword',
    },
    BlinkCmpKindVariable = {
        link ='CmpItemKindVariable',
    },
    BlinkCmpKindConstant = {
        link ='CmpItemKindConstant',
    },
    BlinkCmpKindReference = {
        link ='CmpItemKindReference',
    },
    BlinkCmpKindValue = {
        link ='CmpItemKindValue',
    },
    BlinkCmpKindFunction = {
        link ='CmpItemKindFunction',
    },
    BlinkCmpKindMethod = {
        link ='CmpItemKindMethod',
    },
    BlinkCmpKindConstructor = {
        link ='CmpItemKindConstructor',
    },
    BlinkCmpKindClass = {
        link ='CmpItemKindClass',
    },
    BlinkCmpKindInterface = {
        link ='CmpItemKindInterface',
    },
    BlinkCmpKindStruct = {
        link ='CmpItemKindStruct',
    },
    BlinkCmpKindEvent = {
        link ='CmpItemKindEvent',
    },
    BlinkCmpKindEnum = {
        link ='CmpItemKindEnum',
    },
    BlinkCmpKindUnit = {
        link ='CmpItemKindUnit',
    },
    BlinkCmpKindModule = {
        link ='CmpItemKindModule',
    },
    BlinkCmpKindProperty = {
        link ='CmpItemKindProperty',
    },
    BlinkCmpKindField = {
        link ='CmpItemKindField',
    },
    BlinkCmpKindTypeParameter = {
        link ='CmpItemKindTypeParameter',
    },
    BlinkCmpKindEnumMember = {
        link ='CmpItemKindEnumMember',
    },
    BlinkCmpKindOperator = {
        link ='CmpItemKindOperator',
    },
    BlinkCmpLabelMatch = {
        fg = monokai.scheme.orange,
    },

    -- hl groups specified for Gitsigns
    GitSignsAdd = { fg = '#87ff5f', ctermfg = 119,},
    GitSignsDelete = { fg = '#d75f5f', ctermfg = 167,},
    GitSignsChange = { fg = '#ffff5f', ctermfg = 227,},

    LuaLineDiffAdd = {link = 'GitSignsAdd'},
    LuaLineDiffDelete = {link = 'GitSignsDelete'},
    LuaLineDiffChange = {link = 'GitSignsChange'},

    -- hl groups for tabline/tabby
    TabbyLineFill = {bg = '#000000'},
    TabbyLine = {fg = oabt_scheme.comment_fg, bg = '#111111'},
    TabbyLineSel = {fg = '#ffffff', bg = oabt_scheme.background, bold = true, italic = true},

    -- hl groups specified for nvim-tree
    NvimTreeIndentMarker = {link = 'NonText'},

    -- hl groups specified for neo-tree
    NeoTreeGitModified = {link = 'GitSignsChange'},
    NeoTreeGitUntracked = {link = 'GitSignsAdd'},
    NeoTreeIndentMarker = {link = 'NonText'},
    NeoTreeNormal = {bg = oabt_scheme.oabt_dark_bg},
    NeoTreeNormalNC = {bg = oabt_scheme.oabt_dark_bg},
    NeoTreeFloatNormal = {bg = oabt_scheme.background},

    -- hl groups specified for dapui
    -- the control hl groups of dapui-repl depends on WinBar & WinBarNC
    -- default WinBar & WinBarNC have different bg in Nvim 0.10
    WinBar = {bg = oabt_scheme.winbar_bg},
    WinBarNC = {bg = oabt_scheme.winbar_bg},

    -- hl groups specified for treesitter-context
    TreesitterContextBottom = {
        bg = oabt_scheme.pmenu_bg,
        underline = true,
        sp = oabt_scheme.oabt_search_yellow
    },
    TreesitterContext = {bg = oabt_scheme.pmenu_bg},
    TreesitterContextLineNumber = {link = 'TreesitterContext'},

    -- override the tree-sitter highligh groups
    ['@comment'] = {link = 'Comment'},
    ['@constructor'] = {link = 'Function'},
    ['@method'] = {link = 'Function'},
    ['@method.call'] = {link = 'Function'},
    ['@function'] = {link = 'Function'},
    ['@function.call'] = {link = 'Function'},
    ['@keyword.function'] = {link = 'Keyword'},

    -- ['@function'] = {link = 'Function'},
    -- ['@function.builtin'] = {link = 'Function'},
    -- ['@function.macro'] = {link = 'Macro'},
    -- ['@constant'] = {link = 'Macro'},

    -- @oabt: temporary remap for the upstream treesitter capture name update
    -- reference: https://github.com/nvim-treesitter/nvim-treesitter/issues/4799
    ['@variable.parameter'] = {link = '@parameter'},
    ['@variable.member'] = {link = '@field'},
    ['@module'] = {link = '@namespace'},
    ['@number.float'] = {link = '@float'},
    ['@string.special.symbol'] = {link = '@symbol'},
    ['@string.regexp'] = {link = '@string.regex'},
    ['@markup.strong'] = {link = '@text.strong'},
    ['@markup.italic'] = {link = '@text.italic'},
    ['@markup.strikethrough'] = {link = '@text.strikethrough'},
    ['@markup.heading'] = {link = '@text.title'},
    ['@markup.raw'] = {link = '@text.literal'},
    ['@markup.link'] = {link = '@text.reference'},
    ['@markup.link.url'] = {link = '@text.uri'},
    ['@markup.link.label'] = {link = '@string.special'},
    ['@markup.list'] = {link = '@punctuation.special'},

}

monokai.setup({
    scheme = oabt_scheme,
    custom_hlgroups = oabt_hl_group,
})

