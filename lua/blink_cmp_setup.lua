local blink_cmp = require('blink.cmp')

local files = require('blink.cmp.fuzzy.download.files')

local use_rust = true
local fuzzy_sort_in_lua = nil
if not use_rust then
    fuzzy_sort_in_lua = {
        function(a, b)
            local source_prior = {
                path = 4,
                lsp = 3,
                snippets = 2,
                buffer = 1
            }
            -- avoid cmdline indexing nil itme
            if (source_prior[a.source_id] and source_prior[b.source_id]) then
                return source_prior[a.source_id] > source_prior[b.source_id]
            end
            return nil
        end,
        "score",
        "sort_text",
    }
end

-- @oabt: get the version from the recent released tag (abbrev=0)
local function get_git_tag()
    local repo_dir = vim.fs.root(files.root_dir, '.git')
    if not repo_dir then return nil end

    local git_ret = vim.system({
        'git',
        '--git-dir', vim.fs.joinpath(repo_dir, '.git'),
        '--work-tree', repo_dir,
        'describe', '--tags',
        '--abbrev=0',
    }, { cwd = files.root_dir}):wait(500)

    -- if ~git_ret then return nil end
    if git_ret == nil or git_ret.code ~= 0 then return nil end
    return vim.split(git_ret.stdout, '\n')[1]
end

local recent_ver = get_git_tag()

local has_devicons = package.loaded['nvim-web-devicons']

local menu_columns_icon = {
    { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 }
}

local menu_columns_no_icon = {
    { "label", "label_description", gap = 1 }, {"kind" }
}


blink_cmp.setup({

fuzzy = {
    implementation = use_rust and "prefer_rust_with_warning" or "lua",

    max_typos = function(keyword)
        -- local length = #keyword
        return 0
    end,

    sorts = fuzzy_sort_in_lua,

    prebuilt_binaries = {
        force_version = recent_ver,
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
            -- should_show_items = function(ctx)
            --     return ctx.trigger.initial_kind ~= 'trigger_character'
            -- end,

            score_offset = -10,

            min_keyword_length = function(ctx)
                if ctx.trigger.initial_kind ~= 'trigger_character' then
                    return 0
                else
                    return 3
                end
            end,

            opts = {
                -- get all buffers, even ones like neo-tree
                -- get_bufnrs = vim.api.nvim_list_bufs

                -- or (recommended) filter to only "normal" buffers
                -- get_bufnrs = function()
                --     return vim.tbl_filter(function(bufnr)
                --         return vim.bo[bufnr].buftype == ''
                --     end, vim.api.nvim_list_bufs())
                -- end
                max_async_buffer_size = 1000000,
                max_total_buffer_size = 1100000,
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
