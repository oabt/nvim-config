
local dapui = require('dapui')

dapui.setup({
    layouts = {
        {
        elements = { {
            id = "scopes",
            size = 0.25
          }, {
            id = "watches",
            size = 0.25
          } },
        position = "left",
        size = 40
      }, {
        elements = { {
            id = "breakpoints",
            size = 0.5
          }, {
            id = "stacks",
            size = 0.5
          } },
        position = "right",
        size = 30
      }, {
        elements = { {
            id = "repl",
            size = 0.5
          }, {
            id = "console",
            size = 0.5
          } },
        position = "bottom",
        size = 10
        }
    }
})

-- TODO: mapping for debugger: step-into step-out step-over contiue

vim.cmd([[command! DapToggleUI exec "lua require'dapui'.toggle()"]])

