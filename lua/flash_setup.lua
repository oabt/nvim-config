-- folke/flash.nvim

local flash = require('flash')

flash.setup({

    multi_window = true,
    search = {
        multi_window = true,
        mode = "exact",
    },
    jump = {
        pos = "start"
    },
    label = {
        uppercase = true,
        after = false,
        before = true,
        reuse = "lowercase"
    },
    modes = {
        char = { -- do not trigger flash on {'f', 'F', 't', 'T', ',', ';'}
            enabled = false,
        },
        search = {
            enabled = false,
        },
    },

})

vim.keymap.set({'n', 'v'}, '<Leader>e', function()
    require("flash").jump()
end)

