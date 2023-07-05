
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

-- <Leader> is required by several plugins,
-- setup here before plugins loaded.
vim.g.mapleader = ' ' 

require("lazy").setup(
    { -- plugins
        -- manage lazy.nvim itself
        {"folke/lazy.nvim",
            version = "*",
            --pin = true,
        },

        ------------ UI related ------------------------------
        {"mhinz/vim-startify",
            lazy = false,
        },
        {"sheerun/vim-polyglot",
            event = "VeryLazy",
        },
        {"nvim-tree/nvim-web-devicons",
            lazy = true,
            config = function() require('nvim-web-devicons-setup') end,
        },
        {'nvim-lualine/lualine.nvim',
            event = "VeryLazy",
            --lazy = false,
            config = function() require('lualine-setup') end,
        },
        {"akinsho/bufferline.nvim",
            event = "VeryLazy",
            version = "*",
            config = function() require('bufferline-setup') end,
        },

        ------------------ auto completion ----------------------
        {"hrsh7th/nvim-cmp",
            event = "InsertEnter",
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
            lazy = true,
            config = function() require('lspconfig-setup') end,
        },

        ---------------------- misc ------------------------------
        {"skywind3000/asyncrun.vim",
            cmd = "AsyncRun",
        },
        {"lewis6991/gitsigns.nvim",
            event = "VeryLazy",
            config = function() require('gitsigns-setup') end,
        }
    },
    { -- lazy.nvim configs
        root = vim.env.HOME .. "/.nvim/lazy_plug",
        lockfile = vim.env.HOME .. "/.nvim/lazy_plug/lazy-lock.json",
    }
)


if vim.g.neovide then
    require('neovide-setup')
end

--if exists("g:neovide")
--  lua require('neovide-setup')
--endif

vim.cmd([[runtime vim-legacy.vim]])

