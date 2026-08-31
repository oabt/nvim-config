-- @oabt: try nvim-treesitter
-- {"nvim-treesitter/nvim-treesitter",
--     event = "VeryLazy",
--     config = function() require("nvim_treesitter_setup") end,
-- },

if vim.uv.os_uname().sysname == "Windows_NT" then
    vim.env.CC = "gcc"
end

-- vim.env.http_proxy = "http://127.0.0.1:1080"
-- vim.env.https_proxy = "http://127.0.0.1:1080"

local ts_install_dir = vim.env.HOME .. "/.nvim/lazy_plug/nvim-treesitter"
local install_lang = {}
-- install_lang = { "c", "lua", "vim", "vimdoc", "query", "bash", "markdown", "markdown_inline", "cpp", "python", "make", "cmake" }

require("nvim-treesitter").setup({
    install_dir = ts_install_dir, -- already in runtimepath
})

require("nvim-treesitter").install(install_lang)

-- @oabt (Claude): TSInstall exposes the plugin's shipped queries (runtime/queries/<lang>)
-- as links under queries/<lang>: symlinks on unix, junctions on windows.
-- Links store absolute targets (windows junctions can only be absolute) and
-- dangle whenever the install dir moves, so replace every one of them with a
-- plain copy for cross-platform relocatability.  Mirrors the plugin's own
-- do_copy_queries (install.lua), which nvim-treesitter only uses for queries
-- whose source is ephemeral -- the runtime ones are always linked.
-- Runs at startup -- that is what actually keeps the copies fresh: lazy
-- plugin updates change runtime/queries without any TSUpdate ever firing.
-- The 'User TSUpdate' hook below is only a mid-session fallback for manual
-- TS commands: the plugin fires the event at the START of
-- TSInstall/TSUpdate/TSUninstall (install.lua reload_parsers), synchronously
-- from the install() call above -- before the autocmd below even exists.
-- Languages whose source is unchanged are skipped entirely: each copy carries
-- a .sync_stamp file with a name:size:mtime signature of its source.
local function sync_query_copies()
    local queries_dir = vim.fs.normalize(ts_install_dir .. "/queries")
    if not vim.uv.fs_stat(queries_dir) then return end
    local root = vim.fs.dirname(queries_dir) -- the nvim-treesitter install dir
    local stamp = '.sync_stamp'

    -- signature of a query dir: the sorted "name:size:mtime" of its source files.
    -- Stored in the copy, it skips the re-copy while the source stays unchanged
    -- (an mtime-only check cannot work: utime cannot restore sub-second stamps).
    local function dir_signature(src)
        local sig = {}
        for f in vim.fs.dir(src) do
            local st = vim.uv.fs_stat(src .. '/' .. f)
            sig[#sig + 1] = f .. ':' .. st.size .. ':' .. st.mtime.sec .. ':' .. st.mtime.nsec
        end
        table.sort(sig)
        return table.concat(sig, '|')
    end

    local function read_stamp(path)
        local fh = io.open(path)
        if not fh then return end
        local sig = fh:read('a')
        fh:close()
        return sig
    end

    -- snapshot the names first: links below get replaced by real directories
    local names = {}
    for name in vim.fs.dir(queries_dir) do
        names[#names + 1] = name
    end
    for _, name in ipairs(names) do
        local src = root .. '/runtime/queries/' .. name
        local dst = queries_dir .. '/' .. name
        if vim.uv.fs_stat(src) then
            local sig = dir_signature(src)
            if read_stamp(dst .. '/' .. stamp) == sig then
                goto continue -- up to date
            end
            local lstat = vim.uv.fs_lstat(dst)
            if lstat and lstat.type ~= 'directory' then
                vim.uv.fs_unlink(dst) -- a symlink/junction from TSInstall
            end
            vim.uv.fs_mkdir(dst, 493) -- tonumber('755', 8); no-op when it exists
            local seen = {}
            for f in vim.fs.dir(src) do
                seen[f] = true
                vim.uv.fs_copyfile(src .. '/' .. f, dst .. '/' .. f)
            end
            for f in vim.fs.dir(dst) do -- drop files removed from the source
                if not seen[f] and f ~= stamp then
                    vim.uv.fs_unlink(dst .. '/' .. f)
                end
            end
            local fh = io.open(dst .. '/' .. stamp, 'w')
            if fh then fh:write(sig) fh:close() end
        end
        ::continue::
    end
end

-- sync_query_copies()
vim.api.nvim_create_autocmd('User', {
    pattern = 'TSUpdate',
    callback = sync_query_copies,
    desc = "copy nvim-treesitter queries instead of linking them",
})

for i, v in ipairs(install_lang) do
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {v},
      callback = function()
          vim.treesitter.start()
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo[0][0].foldmethod = 'expr'
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
      desc = v .. " ts highlight,fold,indent",
    })
end

----------------------------- nvim-treesitter cfg on archived 'master' branch

-- force git download through proxy is easier
-- require("nvim-treesitter.install").prefer_git = true
-- require("nvim-treesitter.install").compilers = {"gcc", "clang"}

-- require'nvim-treesitter.configs'.setup({
--     -- A list of parser names, or "all" (the five listed parsers should always be installed)
--     ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "bash", "markdown", "markdown_inline", "cpp", "python", "make", "cmake"},

--     -- Install parsers synchronously (only applied to `ensure_installed`)
--     sync_install = false,

--     -- Automatically install missing parsers when entering buffer
--     -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
--     auto_install = false,

--     -- List of parsers to ignore installing (or "all")
--     -- ignore_install = { "javascript" },

--     ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
--     -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
--     parser_install_dir = vim.env.HOME .. "/.nvim/lazy_plug/nvim-treesitter", -- already in runtimepath

--     highlight = {
--         enable = true,

--         -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
--         -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
--         -- the name of the parser)
--         -- list of language that will be disabled
--         -- disable = { "c", "rust" },
--         -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
--         disable = function(lang, buf)
--             local max_filesize = 1024 * 1024 * 10 -- 10MB size limit
--             local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
--             if ok and stats and stats.size > max_filesize then
--                 return true
--             end
--         end,

--         -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--         -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
--         -- Using this option may slow down your editor, and you may see some duplicate highlights.
--         -- Instead of true it can also be a list of languages
--         additional_vim_regex_highlighting = {},
--     },
-- })

