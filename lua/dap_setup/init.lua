
local dap = require('dap')

dap.listeners.after.event_initialized["dapui_config"] = function()
    require('dapui').open({})
end

--dap.listeners.before.event_terminated["dapui_config"] = function()
--    require('dapui').close({})
--end


--dap.listeners.before.event_exited["dapui_config"] = function()
--    require('dapui').close({})
--end

------------------ C/C++ adapters and configuration ------------------------
dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        command =  "codelldb",
        args = {"--port", "${port}"},

        detached = function ()
            if vim.loop.os_uname().sysname == "Windows_NT" then
                return false
            else
                return true
            end
        end
    },

}

dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = 'OpenDebugAD7',
    options = {
        detached = false,
        --detached = function ()
            --if vim.loop.os_uname().sysname == "Windows_NT" then
                --return false
            --else
                --return true
            --end
        --end,
    }
}

dap.configurations.cpp = {
    { ----------------------- using codelldb as debugger ----------------------
        name = "Launch file with codelldb",
        type = "codelldb",
        request = "launch",

        program = function()
            -- input the path of the executable
            local exe_path = ""
            vim.ui.input(
                {
                    prompt = 'Path to executable: ',
                    default = vim.fn.getcwd() .. '/',
                    copmletion = 'file', -- TODO: not working with nvim-cmp
                },
                function(input) exe_path = input end
            )
            return exe_path
        end,

        args = function ()
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
        end,

        cwd = function()
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
        end,

        stopOnEntry = false,
    },

    { ----------------------- using cpptools as debugger ----------------------
        name = "Launch file with cpptools",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        args = function ()
            -- input the args
            args_str = vim.fn.input('args to be passed to program: ')
            args_list = {}

            -- %S represents the non-space characters, %w represents all alphanumeric characters
            for arg in args_str:gmatch("%S+") do table.insert(args_list, arg) end

            return args_list
        end,
        stopAtEntry = false,
        --setupCommands = { 
        --    text = '-enable-pretty-printing',
        --    description =  'enable pretty printing',
        --    ignoreFailures = false 
        --},
    },
    { ----------------------- Attach to gdb server ----------------------
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = 'gdb',
        cwd = '${workspaceFolder}',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = function ()
            -- input the args
            args_str = vim.fn.input('args to be passed to program: ')
            args_list = {}

            -- %S represents the non-space characters, %w represents all alphanumeric characters
            for arg in args_str:gmatch("%S+") do table.insert(args_list, arg) end

            return args_list
        end,
        --setupCommands = { 
        --    text = '-enable-pretty-printing',
        --    description =  'enable pretty printing',
        --    ignoreFailures = false 
        --},
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

