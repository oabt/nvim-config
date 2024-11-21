
        -- {"nvim-treesitter/nvim-treesitter-context",
        --     event = "VeryLazy",
        --     config = function() require('treesitter_context') end,
        -- }
local tscontext = require('treesitter-context')

local oabt_context_group = vim.api.nvim_create_augroup('oabt_context_enable', {})

local oabt_context_status = false -- initialize as disabled

local function oabt_enable_context()
    tscontext.enable()

    -- @oabt: trigger the update of the attached buffer list
    -- vim.cmd("doautocmd treesitter_context_update BufReadPost")
    vim.api.nvim_exec_autocmds('BufReadPost', {group='treesitter_context_update'})

    -- @oabt: trigger the update of the context render
    -- vim.cmd("doautocmd treesitter_context_update CursorMoved")
    vim.api.nvim_exec_autocmds('CursorMoved', {group='treesitter_context_update'})

    vim.api.nvim_create_autocmd({"BufEnter", "WinEnter"},
        {
            callback = function(args)
                -- @oabt: trigger the update of the attached buffer list
                -- vim.cmd("doautocmd treesitter_context_update BufReadPost")
                vim.api.nvim_exec_autocmds('BufReadPost', {group='treesitter_context_update'})
            end,
            group = oabt_context_group
        }
    )
end

local function oabt_disable_context()
    tscontext.disable()
    vim.api.nvim_create_augroup('oabt_context_enable', {})
end

local function oabt_toggle_context()
    if oabt_context_status then
        oabt_disable_context()
        oabt_context_status = false
        vim.notify("treesitter-context disabled")
    else
        oabt_enable_context()
        oabt_context_status = true
        vim.notify("treesitter-context enabled")
    end
end

vim.keymap.set('n', '<leader>b',
    tscontext.toggle,
    {desc="Toggle the treesitter-context"}
)

tscontext.setup{
    enable = oabt_context_status, -- Enable this plugin (Can be enabled/disabled later via commands)
    multiwindow = false,
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 20, -- Maximum number of lines to show for a single context
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'

    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,

    zindex = 20, -- The Z-index of the context window
    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

