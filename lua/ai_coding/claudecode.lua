local cc = require('claudecode')

cc.setup({
    terminal_cmd = "mtclaude",
    focus_after_send = true,
    terminal = {
        provider = "native",
    }
})

vim.api.nvim_create_user_command("ClaudeCodeLine", function()
    vim.cmd("normal! V")
    vim.cmd("ClaudeCodeSend")
end, {})

vim.api.nvim_create_user_command("ClaudeCodeFile", function()
    local file_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
    vim.cmd("ClaudeCodeAdd " .. vim.fn.fnameescape(file_name))
end, {})
