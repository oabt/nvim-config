        -- {"nvimdev/dashboard-nvim",
        --     lazy = false,
        --     config = function() require('dashboard_setup') end,
        -- },

local dashboard = require('dashboard')

require('dbsession').setup()

vim.cmd([[hi default link DashboardHeader String]])
--vim.cmd([[hi default link DashboardShortCut Type]])

local plugin_info = {
    {
        icon = '󱎘 ',
        icon_hl = 'Error',
        desc = 'Quit',
        desc_hl = 'Keyword',
        key = 'q',
        key_hl = 'Error',
        key_format = ' [%s]',
        action = 'q'
    },
    {
        icon = ' ',
        icon_hl = 'Special',
        desc = 'Plugin Manager',
        desc_hl = 'Keyword',
        key = 'L',
        key_hl = 'Number',
        key_format = ' [%s]',
        action = 'Lazy'
    },
    {
        icon = ' ',
        icon_hl = 'Special',
        desc = 'Plugin Update',
        desc_hl = 'Keyword',
        key = 'U',
        key_hl = 'Number',
        key_format = ' [%s]',
        action = 'Lazy update'
    },
}

-- local function get_sessions_opts()
-- end
-- get_sessions_opts()

local function set_center_opts()
    local center_opts = {}
    for _, opt in ipairs(plugin_info) do
        table.insert(center_opts, opt)
    end

    -- local sessions_files = vim.split(vim.fn.glob('~/.nvim/sessions/*'), '\n')
    local session_names = require('dbsession').complete_list()
    for idx, session_name in ipairs(session_names) do
        local session_opt = {
            desc = 'Session: ' .. session_name,
            desc_hl = 'Identifier',
            key = tostring(idx-1),
            key_hl = 'Number',
            key_format = ' [%s]',
            action = 'SLoad ' .. session_name,
        }
        table.insert(center_opts, session_opt)
    end
    return center_opts
end

local db_config = {
    shortcut_type = "number",
    theme = "doom",
    disable_move = true,    --  default is false disable move keymap for hyper
    hide = {
        statusline = true,
        tabline = false,
    },
    config = {
        -- packages = {enable = true},
        header = {

            [[                ┌────────────────────────────┐                ]],
            [[                │ ┌────────────────────────┐ │                ]],
            [[                │ │ oabt:~$ nvim           │ │                ]],
            [[                │ │                        │ │                ]],
            [[                │ │                        │ │                ]],
            [[                │ │                        │ │                ]],
            [[                │ │                        │ │                ]],
            [[                │ └────────────────────────┘ │                ]],
            [[                └\__________________________/┘                ]],
            [[             ,────\_____      []      _____/──────┐           ]],
            [[            /          /______________\          /│           ]],
            [[           /____________________________________/ │____       ]],
            [[           │  _ _ _                            │  /   (       ]],
            [[           │  o o o                 [───────]  │ /    _)_     ]],
            [[           └───────────────────────────────────┘'    /  /     ]],
            [[       /-───────────────────────────────────-/|     ( )/      ]],
            [[     /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/ /                ]],
            [[   /-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/ /                  ]],
            [[   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                    ]],
            [[                                                              ]],

        }, -- end config.header
        center = set_center_opts(),
       -- footer = {},
    }, --end config
}

-- set_center_opts()

local function dashboard_update() -- update the session info
    db_config.config.center = set_center_opts()
    dashboard.setup(db_config)
end

vim.api.nvim_create_user_command('Dashboard',
    function() -- override the Dashboard command
        dashboard_update()
        dashboard:instance()
    end,
    {}
)

vim.keymap.set('n', ';t', '<cmd>tabnew<cr><cmd>Dashboard<cr>')

dashboard.setup(db_config)

