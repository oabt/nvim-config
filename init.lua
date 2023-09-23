
--local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazypath = vim.env.HOME .. "/.nvim/lazy_plug/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
vim.cmd([[runtime vim-legacy.vim]])
-- require('auto_commands')
-- require('settings')
-- require('keymappings')

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
            config = function() require('monokai-setup') end,
        },
        {"sheerun/vim-polyglot",
            event = "VeryLazy",
            config = function()
                vim.cmd([[runtime vim_plugins_config/vim-polyglot-setup.vim]])
            end,
        },

        ------------ UI related ------------------------------
        {"mhinz/vim-startify",
            lazy = false,
            config = function()
                vim.cmd([[runtime vim_plugins_config/startify-setup.vim]])
            end,
        },
        {"nvim-tree/nvim-web-devicons",
            --enabled = false,
            lazy = true,
            config = function() require('nvim-web-devicons-setup') end,
        },
        {'nvim-lualine/lualine.nvim',
            event = "VeryLazy",
            dependencies = {"nvim-tree/nvim-web-devicons"},
            config = function() require('lualine-setup') end,
        },
        {"akinsho/bufferline.nvim",
            event = "VeryLazy",
            dependencies = {"nvim-tree/nvim-web-devicons"},
            version = "*",
            config = function() require('bufferline-setup') end,
        },

        ------------------ auto completion ----------------------
        {"hrsh7th/nvim-cmp",
            event = {"InsertEnter", "CmdlineEnter"},
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "notomo/cmp-neosnippet",
                "Shougo/neosnippet.vim",
                "Shougo/neosnippet-snippets",
            },
            config = function() require('nvim-cmp-setup') end,
        },

        ------------------ edit ----------------------------------
        {"preservim/nerdcommenter",
            keys = {{"<Leader>c", mode={"n", "v"}},},
            config = function()
                vim.cmd([[runtime vim_plugins_config/nerdcommenter-setup.vim]])
            end,
        },
        {"windwp/nvim-autopairs",
            event = "InsertEnter",
            config = function() require('nvim-autopairs-setup') end,
        },
        {"kylechui/nvim-surround",
            version = "*",
            event = "VeryLazy",
            config = function() require('nvim-surround-setup') end,
        },

        ---------------- navigation -----------------------------
        {"nvim-telescope/telescope.nvim",
            cmd = "Telescope",
            keys = { -- the keys configured in telescope-setup.lua
                "<C-p>", "<leader>d",
                "f<C-p>", "ff<C-p>",
                "<leader>a", "f<leader>a",
                "<leader><leader>a", "f<leader><leader>a",
            },
            branch = "0.1.x",
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            config = function() require('telescope-setup') end,
        },
        {"nvim-telescope/telescope-fzf-native.nvim",
            lazy = true,
            build = 'make',
        },
        {"phaazon/hop.nvim",
            keys = {{"<Leader>e", mode={"n", "v"}},},
            config = function() require('hop-setup') end,
        },
        {"nvim-tree/nvim-tree.lua",
            version = "*",
            cmd = "NvimTreeToggle",
            keys = "<F4>",
            config = function() require('nvim-tree-setup') end,
        },

        ------------------- LSP configs --------------------------
        {"neovim/nvim-lspconfig",
            --lazy = true,
            dependencies = {"nvim-tree/nvim-web-devicons"},
            event = {"VeryLazy"},
            config = function() require('lspconfig-setup') end,
        },

        ------------------- DAP configs --------------------------
        {"mfussenegger/nvim-dap",
            lazy = true,
            config = function() require('dap-setup') end,
        },
        
        {"rcarriga/nvim-dap-ui",
            cmd = {
                "DapContinue",
                "DapToggleBreakpoint",
                "DapToggleUI",
            },
            dependencies = {"mfussenegger/nvim-dap"},
            config = function() require('dapui-setup') end,
        },

        ---------------------- misc ------------------------------
        {"skywind3000/asyncrun.vim",
            cmd = "AsyncRun",
            keys = {"<Leader>s", "<Leader>q"},
            config = function()
                vim.cmd([[runtime vim_plugins_config/asyncrun-setup.vim]])
            end,
        },
        {"lewis6991/gitsigns.nvim",
            event = "VeryLazy",
            config = function() require('gitsigns-setup') end,
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

