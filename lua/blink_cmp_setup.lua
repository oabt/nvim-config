local blink_cmp = require('blink.cmp')

local has_devicons = package.loaded['nvim-web-devicons']

local menu_columns_icon = {
    { "label", "label_description", gap = 1 }, { "kind_icon", "kind" }
}

local menu_columns_no_icon = {
    { "label", "label_description", gap = 1 }, {"kind" }
}


blink_cmp.setup({

fuzzy = {
    implementation = "prefer_rust_with_warning",
    -- implementation = "lua",

    prebuilt_binaries = {
        proxy = {
            url = "127.0.0.1:1080",
        }
    },
},

completion = {

    keyword = {
        range = 'full',
    },

    menu = {
        border = 'single',
        min_width = 15,
        max_height = 25,

        draw = {
            columns = has_devicons and menu_columns_icon or menu_columns_no_icon
        }
    },

    documentation = {
        auto_show = true,
        window = { border = 'single' }
    },

    list = {
        selection = {
            preselect = false,
        }
    }
},

signature = { window = { border = 'single' } },

sources = {
    -- `lsp`, `buffer`, `snippets`, `path` and `omni` are built-in
    -- so you don't need to define them in `sources.providers`
    -- default = { 'lsp', 'buffer', 'snippets', 'path' },

    providers = {
        buffer = {
            should_show_items = function(ctx)
                return ctx.trigger.initial_kind ~= 'trigger_character'
            end,

            min_keyword_length = 2,

            opts = {
                -- get all buffers, even ones like neo-tree
                -- get_bufnrs = vim.api.nvim_list_bufs

                -- or (recommended) filter to only "normal" buffers
                -- get_bufnrs = function()
                --     return vim.tbl_filter(function(bufnr)
                --         return vim.bo[bufnr].buftype == ''
                --     end, vim.api.nvim_list_bufs())
                -- end
            },
        },

        lsp = {
            fallbacks = {},
        },

        path = {
            opts = {
                trailing_slash = false,
            }
        },

        snippets = {
            should_show_items = function(ctx)
                return ctx.trigger.initial_kind ~= 'trigger_character'
            end,
        },
    }
},

keymap = {
    -- set to 'none' to disable the 'default' preset
    preset = 'default',

    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide' },
    ['<C-y>'] = { 'select_and_accept' },

    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
    ['<Tab>'] = { 'select_next', 'fallback' },

    ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },

    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

    ['<C-k>'] = {'accept', 'snippet_forward', 'fallback' },
    -- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

},

cmdline = {
    keymap = {
        preset = "cmdline",

        ['<C-p>'] = {},
        ['<C-n>'] = {},

    },
    completion = {
        menu ={
            auto_show = true,
        },
        list = {
            selection = {
                preselect = false,
            }
        }
    }
}


})
