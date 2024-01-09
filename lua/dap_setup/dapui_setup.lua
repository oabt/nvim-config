
local dapui = require('dapui')

local function exist_devicons()
    if package.loaded['nvim-web-devicons'] == nil then
        return false
    else
        return true
    end
end

local function repl_icons()
    local repl_prompt = {
        disconnect = "Disconnect",
        pause = "Pause",
        play = "Run",
        run_last = "Run Last",
        step_back = "StepBack",
        step_into = "StepIn",
        step_out = "StepOut",
        step_over = "StepOver",
        terminate = "Terminate",
    }

    local repl_prompt_no_icons = {
        disconnect = "Disconnect",
        pause = "Pause",
        play = "Run",
        run_last = "Run Last",
        step_back = "StepBack",
        step_into = "StepIn",
        step_out = "StepOut",
        step_over = "StepOver",
        terminate = "Terminate",
    }
    if exist_devicons() then
        return repl_prompt
    else
        return repl_prompt_no_icons
    end
end

dapui.setup({
    controls = {
        element = "repl",
        enabled = true,
        icons = repl_icons(),
    },
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

vim.api.nvim_create_user_command('DapToggleUI',
    function(opts) dapui.toggle() end,
    { desc = "toggle the DAP UI" }
)

-- set the signs/icons for dap w/t and w/o web-devicons
if exist_devicons() then
    vim.fn.sign_define('DapBreakpoint', {text='', texthl='Debug', linehl='', numhl=''})
    vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='Debug', linehl='', numhl=''})
    vim.fn.sign_define('DapStopped', {text='', texthl='Debug', linehl='', numhl=''})
else
    vim.fn.sign_define('DapBreakpoint', {text='B', texthl='Debug', linehl='', numhl=''})
    vim.fn.sign_define('DapBreakpointCondition', {text='C', texthl='Debug', linehl='', numhl=''})
    vim.fn.sign_define('DapStopped', {text='→', texthl='Debug', linehl='', numhl=''})
end

