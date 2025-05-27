
--local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazypath = vim.env.HOME .. "/.nvim/lazy_plug/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

---- <Leader> is required by several plugins,
---- setup here before plugins loaded.
--vim.g.mapleader = ' ' 
--vim.cmd([[runtime vim-legacy.vim]])
require('auto_commands')
require('settings')
require('keymaps')

require("lazy").setup(
    { -- plugins
        -- manage lazy.nvim itself
        {"folke/lazy.nvim",
            version = "*",
            --pin = true,
        },

        ------------- themes/color scheme/highlight-------------------
        {"ofirgall/ofirkai.nvim",
            lazy = false,
            priority = 1001,
            config = function() require('monokai_setup') end,
        },
        -- {"sheerun/vim-polyglot", -- vim-polyglot can be a fall back of tree-sitter
        --     event = "VeryLazy",
        --     config = function()
        --         vim.cmd([[runtime vim_legacy/vim-polyglot-setup.vim]])
        --     end,
        -- },
        {"nvim-treesitter/nvim-treesitter",
            event = "VeryLazy",
            config = function() require("nvim_treesitter_setup") end,
        },

        ------------ UI related ------------------------------
        -- {"oabt/dashboard-nvim",
        --     event = "VimEnter",
        --     config = function() require('dashboard_setup') end,
        -- },
        {"nvim-tree/nvim-web-devicons",
            cond = vim.g.enable_devicons,
            lazy = true,
            config = function() require('nvim_webdevicons_setup') end,
        },
        {'nvim-lualine/lualine.nvim',
            event = "VeryLazy",
            dependencies = {
                "nvim-tree/nvim-web-devicons",
            },
            config = function() require('lualine_setup') end,
        },
        {'nanozuki/tabby.nvim',
            event = 'VeryLazy',
            dependencies = 'nvim-tree/nvim-web-devicons',
            config = function() require('tabby_setup') end,
        },

        {"echasnovski/mini.animate",
            event = "VeryLazy",
            cond = function()
                if vim.fn.has('gui_running') == 1 then
                    return false
                else
                    return true
                end
            end,
            config = function() require('mini_animate_setup') end,
        },
        ------------------ auto completion ----------------------
        {"saghen/blink.cmp",
            cond = true,
            event = {"InsertEnter", "CmdlineEnter"},
            dependencies = {
                "rafamadriz/friendly-snippets",
            },
            -- version = "*",
            config = function() require('blink_cmp_setup') end,
        },

        {"hrsh7th/nvim-cmp",
            cond = false,
            event = {"InsertEnter", "CmdlineEnter"},
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lsp-signature-help",
                "hrsh7th/cmp-buffer",
                "FelipeLema/cmp-async-path",
                "hrsh7th/cmp-cmdline",
                -- "notomo/cmp-neosnippet",
                -- "Shougo/neosnippet.vim",
                -- "Shougo/neosnippet-snippets",
                "xzbdmw/cmp-mini-snippets",
                "echasnovski/mini.snippets",
                "rafamadriz/friendly-snippets",
            },
            config = function() require('nvim_cmp_setup') end,
        },

        {"echasnovski/mini.snippets",
            lazy = true,
            dependencies = {"rafamadriz/friendly-snippets"},
            config = function() require('mini_snippet_setup') end
        },

        -- {"Shougo/neosnippet.vim",
        --     lazy = true,
        --     config = function()
        --         vim.cmd("runtime vim_legacy/neosnippet-setup.vim")
        --     end,
        -- },

        ------------------ edit ----------------------------------
        --{"preservim/nerdcommenter",
        --    keys = {{"<Leader>c", mode={"n", "v"}},},
        --    config = function()
        --        vim.cmd([[runtime vim_legacy/nerdcommenter-setup.vim]])
        --    end,
        --},
        {"numToStr/Comment.nvim",
            keys = {{"<Leader>c", mode={"n", "v"}},},
            config = function() require('comment_setup') end,
        },
        {"windwp/nvim-autopairs",
            event = "InsertEnter",
            config = function() require('nvim_autopairs_setup') end,
        },
        {"kylechui/nvim-surround",
            version = "*",
            event = "VeryLazy",
            config = function() require('nvim_surround_setup') end,
        },

        {"folke/snacks.nvim",
            cond = true,
            lazy = false,
            priority = 1000,
            config = function() require("snacks_setup") end,
        },

        ---------------- navigation -----------------------------
        {"nvim-telescope/telescope.nvim",
            cond = false,
            cmd = "Telescope",
            keys = { -- the keys configured in telescope-setup.lua
                "<C-p>", "<leader>d", "<leader>f",
                "f<C-p>", "ff<C-p>",
                "<leader>a", "f<leader>a",
            },
            branch = "0.1.x",
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            config = function() require('telescope_setup') end,
        },
        {"nvim-telescope/telescope-fzf-native.nvim",
            lazy = true,
            build = 'make',
        },
        -- {"phaazon/hop.nvim",
        --     keys = {{"<Leader>e", mode={"n", "v"}},},
        --     config = function() require('hop_setup') end,
        -- },
        {"folke/flash.nvim",
            keys = {{"<Leader>e", mode={"n", "v"}},},
            config = function() require('flash_setup') end,
        },
        -- {"nvim-tree/nvim-tree.lua",
        --     version = "*",
        --     cmd = "NvimTreeToggle",
        --     keys = "<F4>",
        --     config = function() require('nvim_tree_setup') end,
        -- },
        {"nvim-neo-tree/neo-tree.nvim",
            version = "*",
            cmd = "Neotree",
            keys = "<F4>",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim",
            },
            config = function() require('neo_tree_setup') end,
        },
        {"nvim-treesitter/nvim-treesitter-context",
            keys = {"<Leader>b"},
            -- event = "VeryLazy",
            config = function() require('treesitter_context') end,
        },

        ------------------- LSP configs --------------------------
        {"neovim/nvim-lspconfig",
            --lazy = true,
            dependencies = {"nvim-tree/nvim-web-devicons"},
            event = {"VeryLazy"},
            config = function() require('lspconfig_setup') end,
        },

        ------------------- DAP configs --------------------------
        {"mfussenegger/nvim-dap",
            lazy = true,
            config = function() require('dap_setup') end,
        },
        {"rcarriga/nvim-dap-ui",
            cmd = {
                "DapContinue",
                "DapToggleBreakpoint",
                "DapToggleUI",
                "DapCondBreakpoint",
            },
            dependencies = {
                "mfussenegger/nvim-dap",
                "nvim-neotest/nvim-nio",
            },
            config = function() require('dap_setup.dapui_setup') end,
        },

        ---------------------- misc ------------------------------
        {"skywind3000/asyncrun.vim",
            cmd = "AsyncRun",
            keys = {"<Leader>s", "<Leader>q"},
            config = function()
                vim.cmd([[runtime vim_legacy/asyncrun-setup.vim]])
            end,
        },
        {"lewis6991/gitsigns.nvim",
            event = "VeryLazy",
            version = "*",
            config = function() require('gitsigns_setup') end,
        }
    },
    { -- lazy.nvim configs
        root = vim.env.HOME .. "/.nvim/lazy_plug",
        lockfile = vim.env.HOME .. "/.nvim/lazy_plug/lazy-lock.json",
        performance = {
            rtp = {
                disabled_plugins = {
                    "gzip",
                    "matchit",
                    --"matchparen",
                    "netrwPlugin",
                    "tarPlugin",
                    "tohtml",
                    "tutor",
                    "zipPlugin",
                    "spellfile",
                },
            },
        },
    }
)

-- the configs of the GUIs
require('gui_config')

