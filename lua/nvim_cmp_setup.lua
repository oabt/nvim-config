local cmp = require('cmp')

cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.

                local mini_snip = require('mini.snippets')
                local insert = mini_snip.config.exapnd.inert or mini_snip.default_insert
                insert({body = args.body})
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
            completion = {
                border = 'single',
                winhighlight = 'Normal:CmpFloat,FloatBorder:CmpFloatBorder,CursorLine:PmenuSel,Search:None',
                zindex = 1001,
            },
            documentation = {
                border = 'single',
                winhighlight = 'Normal:CmpFloat,FloatBorder:CmpFloatBorder,CursorLine:PmenuSel,Search:None',
                zindex = 1002,
            },
        },
        mapping = {
            ['<Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end,
            ['<S-Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end,
            ['<C-n>'] = cmp.mapping(
                function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end,
            {'i','s','v'}),
            ['<C-p>'] = cmp.mapping(
                function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end,
            {'i','s','v'})
        },
        --mapping = cmp.mapping.preset.insert({
        --        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        --        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        --        ['<C-Space>'] = cmp.mapping.complete(),
        --        ['<C-e>'] = cmp.mapping.abort(),
        --        --['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        --    }),
        sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'nvim_lsp_signature_help'},
                -- { name = 'neosnippet' },
                { name = 'mini.snippets',
                  option = {
                      use_minisnippets_match_rule = false,
                      only_show_in_line_start = false,
                  }
                },
                --{ name = 'vsnip' }, -- For vsnip users.
                -- { name = 'luasnip' }, -- For luasnip users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users.
                {
                    name = 'buffer',
                    keyword_length = 2,
                    option = {
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end
                    }
                },
                { name = 'async_path' },
        })
    })

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        { name = 'buffer'},
     })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline({
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item),
        ['<C-n>'] = cmp.config.disable,
        ['<C-p>'] = cmp.config.disable,
    }),
    sources = cmp.config.sources({
        { name = 'async_path' },
        { name = 'cmdline' }, 
    })
})

