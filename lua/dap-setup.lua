
local dap = require('dap')

dap.listeners.after.event_initialized["dapui_config"] = function()
    require('dapui').open({})
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    require('dapui').close({})
end


dap.listeners.before.event_exited["dapui_config"] = function()
    require('dapui').close({})
end

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

dap.configurations.cpp = {
    {
        name = "Launch file",
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
}

dap.configurations.c = dap.configurations.cpp
