local mini_snip = require('mini.snippets')

local gen_loader = mini_snip.gen_loader

mini_snip.setup({
    snippets = {
        gen_loader.from_lang(),
    },

    mappings = {
        expand = '<C-k>',
        stop = '<C-c>',
        jump_next = '<C-k>',
        jump_prev = '',
    },
    expand = {
        -- Resolve raw config snippets at context
        prepare = nil,
        -- Match resolved snippets at cursor position
        match = nil,
        -- Possibly choose among matched snippets
        select = nil,
        -- Insert selected snippet
        insert = nil,
    },
})
