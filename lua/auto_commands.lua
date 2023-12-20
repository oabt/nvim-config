
-- vim.cmd[[autocmd BufEnter * silent! lcd %:p:h]]-- equivalent to autochdir but work better with plugins
vim.api.nvim_create_autocmd( -- automatically change cwd to the file in current buffer
    {"BufEnter"},
    {
        pattern = {"*"},
        command = "silent! lcd %:p:h"
    }
)

vim.api.nvim_create_autocmd( -- jump to the position of last access
    {"BufReadPost"},
    {
        pattern = {"*"},
        callback = function(ev)
            local line_nr = vim.fn.line("'\"")
            if line_nr > 0 and line_nr < vim.fn.line("$") then
                vim.cmd[[normal g'"]]
            end
        end,

    }
)

-- set highlight of the terminal buffers
vim.api.nvim_create_autocmd(
    {"TermOpen"},
    {
        callback = function(ev)
            if vim.bo.buftype == 'terminal' then
                vim.cmd("set winhighlight="..
                    "Normal:TermNormal,"..
                    "LineNr:TermLineNr,"..
                    "CursorLineNr:TermCursorLineNr")
            end
        end,
    }
)

