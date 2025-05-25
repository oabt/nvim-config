require('dbsession').setup()

local function get_sections()
    local sections = {
        { section = "header" },
        { section = "keys", gap = 0, padding = 1 },
        --> insert sessions here
        { section = "startup" },
    }
    local session_names = require('dbsession').complete_list()
    for index, session_name in ipairs(session_names) do
        local session = {
            text = {
                {'Session: ', hl = "Identifier"},
                {session_name, hl = "Identifier", width = 40},
                {'[' .. tostring(index - 1) .. ']', hl = 'Number'},
            },
            action = ':SLoad ' .. session_name,
            key = tostring(index - 1),
        }
        table.insert(sections, 2 + index, session)
    end
    return sections
end

local dashboard_configs = {
    enabled = true,

    -- use current win, buf to open dashboard
    buf = 0,
    win = 0,

    width = 50,
    row = 0, -- dashboard position. nil for center
    col = nil, -- dashboard position. nil for center
    pane_gap = 4, -- empty columns between vertical panes
    autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
    -- These settings are used by some built-in sections
    preset = {
        -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
        ---@type fun(cmd:string, opts:table)|nil
        -- pick = nil,

        -- Used by the `header` section
        header =
        [[
                          ┌────────────────────────────┐                
                          │ ┌────────────────────────┐ │                
                          │ │ oabt:~$ nvim           │ │                
                          │ │                        │ │                
                          │ │                        │ │                
                          │ │                        │ │                
                          │ │                        │ │                
                          │ └────────────────────────┘ │                
                          └\__________________________/┘                
                       ,────\_____      []      _____/──────┐           
                      /          /______________\          /│           
                     /____________________________________/ │____       
                     │  _ _ _                            │  /   (       
                     │  o o o                 [───────]  │ /    _)_     
                     └───────────────────────────────────┘'    /  /     
                 /-───────────────────────────────────-/|     ( )/      
               /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/ /                
             /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/ /                  
             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                    
        ]],

        keys = {
            { icon = " ", key = "q", desc = "Quit", action = ":q" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "U", desc = "Lazy Update", action = ":Lazy update", enabled = package.loaded.lazy ~= nil },
        },
    },
    sections = get_sections(),
}

-- always set showtabline=2 for dashboard
local augroup = vim.api.nvim_create_augroup("dashboard_tabline", { clear = true })
vim.api.nvim_create_autocmd(
    {"User"},
{
    pattern = "SnacksDashboard*",
    group = augroup,
    callback = function(ev)
        vim.opt.showtabline = 2
        vim.opt.laststatus = 3
    end
}
)

vim.api.nvim_create_user_command("Dashboard", function()
    -- update session list
    dashboard_configs.sections = get_sections()

    -- check if there exists a dashboard
    local existed_dashboard = false
    local bufinfo_dict = vim.fn.getbufinfo()
    for _, buf_info in pairs(bufinfo_dict) do
        if vim.fn.getbufvar(buf_info['bufnr'], '&filetype') == 'dashboard' then
            -- delete the existed dashboard
            vim.api.nvim_buf_delete(buf_info['bufnr'], {force=true})

            -- OR reuse the existed dashboard
            -- existed_dashboard = true
            -- vim.cmd("buffer " .. tostring(buf_info['bufnr']))
            break
        end
    end
    if not existed_dashboard then
        require('snacks').dashboard(dashboard_configs)
    end
end,
{}
)

vim.keymap.set('n', ';t', '<cmd>tabnew<cr><cmd>Dashboard<cr>')

return dashboard_configs
