
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

        cwd = '${workspaceFolder}',
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

dap.configurations.c = dap.configurations.cpp
