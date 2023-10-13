-- folke/flash.nvim

local flash = require('flash')

flash.setup({

    multi_window = true,
    search = {
        mode = "exact",
    },
    jump = {
        pos = "start"
    },
    label = {
        uppercase = true,
        reuse = "lowercase"
    },
    modes = {
        char = { -- do not trigger flash on {'f', 'F', 't', 'T', ',', ';'}
            enabled = false,
        }
    },

})

vim.keymap.set({'n', 'v'}, '<Leader>e', function()
    require("flash").jump()
end)

