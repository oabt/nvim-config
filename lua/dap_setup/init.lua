
local dap = require('dap')

dap.listeners.after.event_initialized["dapui_config"] = function()
    require('dapui').open({})
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    require('dapui').close({})
end

local function input_program(back_slash)
    -- input the executable, converse the back slash to slash if back_slash is true
    local exe_path = ""
    local default_path = vim.fn.getcwd()
    if back_slash == true then
        default_path = string.gsub(default_path, "(\\)", "/")
    end
    vim.ui.input(
        {
            prompt = 'Path to executable: ',
            default = default_path .. '/',
            copmletion = 'file', -- TODO: not working with nvim-cmp
        },
        function(input) exe_path = input end
    )
    return exe_path
end

local function input_args()
    -- input the args
    local args_list = {}
    vim.ui.input(
        {
            prompt = 'args to be passed to program: ',
            default = '',
            --copmletion = 'file',
        },
        function(input) -- split the input by 'space'
            -- %S represents the non-space characters, %w represents all alphanumeric characters
            for arg in input:gmatch("%S+") do table.insert(args_list, arg) end
        end
    )

    return args_list
end

local function input_cwd()
    -- input the CWD for execution
    local cwd_input = ""
    vim.ui.input(
        {
            prompt = 'Enter the CWD: ',
            default = vim.fn.getcwd(),
            completion = 'file', -- TODO: not working with nvim-cmp
        },
        function(input) cwd_input = input end
    )
    return cwd_input
end


-- dap.listeners.before.event_exited["dapui_config"] = function()
--     require('dapui').close({})
-- end

------------------ C/C++ adapters and configuration ------------------------
dap.adapters.gdb = {
    -- require gdb 14.1+
    type = "executable",
    command = "gdb",
    args = {"-i", "dap"},
}

dap.adapters.lldb = {
    -- could be rename to lldb-dap in the future
    type = "executable",
    command = vim.fn.executable("lldb-dap") and "lldb-dap" or "lldb-vscode",
    name = "lldb",
}

dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        command =  "codelldb",
        args = {"--port", "${port}"},

        detached = function ()
            if vim.uv.os_uname().sysname == "Windows_NT" then
                return false
            else
                return true
            end
        end
    },

}

dap.configurations.cpp = {
    {
        name = "Launch with lldb-vscode",
        type = "lldb",
        request = "launch",

        program = input_program,

        args = input_args,

        cwd = input_cwd,

        stopOnEntry = false,
    },
    {
        name = "Launch with gdb native",
        type = "gdb",
        request = "launch",

        program = function() return input_program(true) end,

        args = input_args,

        cwd = input_cwd,

        stopAtBeginningOfMainSubprogram = false,
    },
    { ----------------------- using codelldb as debugger ----------------------
        name = "Launch file with codelldb",
        type = "codelldb",
        request = "launch",

        program = input_program,

        args = input_args,

        cwd = input_cwd,

        stopOnEntry = false,
        expressions = "native",
    },
}
-- cpp_templates/init.lua should return a table,
-- containing all the cpp configs that need to be loaded
local cpp_templates = require('dap_setup.cpp_templates')
for _, v in pairs(cpp_templates) do
    table.insert(dap.configurations.cpp, v)
end


dap.configurations.c = dap.configurations.cpp

vim.cmd[[au FileType dap-repl lua require('dap.ext.autocompl').attach()]]

vim.api.nvim_create_user_command('DapCondBreakpoint',
    function(opts) dap.set_breakpoint(opts.args) end,
    {
        nargs = "*",
        desc = "DAP: Set conditional breakpoint",
    }
)

vim.api.nvim_create_user_command('DapRunToCursor',
    function(opts) dap.run_to_cursor(opts.args) end,
    {
        nargs = "*",
        desc = "DAP: run to cursor",
    }
)

vim.keymap.set('n', '<M-5>', function()
    if dap.session() then
        dap.continue()
    end
end,
{desc="Dap Continue"})

vim.keymap.set('n', '<M-6>', function()
    if dap.session() then
        dap.step_over()
    end
end,
{desc="Dap StepOver"})

vim.keymap.set('n', '<M-=>', function()
    if dap.session() then
        dap.step_into()
    end
end,
{desc="Dap StepInto"})

vim.keymap.set('n', '<M-->', function()
    if dap.session() then
        dap.step_out()
    end
end,
{desc="Dap StepOut"})

