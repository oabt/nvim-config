
local dapui = require('dapui')

dapui.setup({
    layouts = {
        { -- left components
            elements = {
                { id = "scopes", size = 0.75 },
                { id = "watches", size = 0.25 } 
            },
            position = "left",
            size = 40
        },
        { -- right components
            elements = {
                { id = "stacks", size = 0.5 },
                { id = "breakpoints", size = 0.5 }
            },
            position = "right",
            size = 30
        },
        { -- bottom components 1 (bottom of the bottom)
            elements = {
                { id = "repl", size = 1 },
            },
            position = "bottom",
            size = 10
        },
        { -- bottom components 2
            elements = {
                { id = "console", size = 1 },
            },
            position = "bottom",
            size = 10
        },
    }
})

-- TODO: mapping for debugger: step-into step-out step-over contiue

vim.cmd([[command! DapToggleUI exec "lua require'dapui'.toggle()"]])

