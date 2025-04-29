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
    }
})
