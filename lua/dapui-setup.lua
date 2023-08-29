
local dapui = require('dapui')

dapui.setup({})

vim.cmd([[command! DapToggleUI exec "lua require'dapui'.toggle()"]])

