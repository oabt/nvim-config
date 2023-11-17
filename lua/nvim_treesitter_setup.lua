-- @oabt: try nvim-treesitter
-- {"nvim-treesitter/nvim-treesitter",
--     event = "VeryLazy",
--     config = function() require("nvim_treesitter_setup") end,
-- },

require'nvim-treesitter.configs'.setup({
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    -- ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false,

    -- List of parsers to ignore installing (or "all")
    -- ignore_install = { "javascript" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
    parser_install_dir = vim.env.HOME .. "/.nvim/lazy_plug/nvim-treesitter", -- already in runtimepath

    highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c", "rust" },
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 1024 * 1024 * 10 -- 10MB size limit
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
})

-- force git download through proxy is easier
require("nvim-treesitter.install").prefer_git = true

