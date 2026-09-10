-- @oabt: try nvim-treesitter
-- {"nvim-treesitter/nvim-treesitter",
--     event = "VeryLazy",
--     config = function() require("nvim_treesitter_setup").setup() end,
-- },
--
-- Everything runs from setup() (loaded by lazy at VeryLazy), which repairs the
-- queries links and then installs/configures.  Trade-off of repairing that
-- late: after relocating the install dir, the buffer(s) opened during startup
-- may render before the links are fixed -- call sync_query_links() from
-- init.lua (before require("lazy").setup) if that ever matters.

local M = {}

local install_dir = vim.fs.normalize(vim.env.HOME .. '/.nvim/lazy_plug/nvim-treesitter')

--------------------------------- queries/<lang> links (see sync_query_links)

-- The <install_dir>/queries/<lang> entries must stay *links* to the shipped
-- queries (<plugin>/runtime/queries/<lang>): relative symlinks on unix,
-- junctions on windows (junctions cannot hold relative targets).
-- nvim-treesitter creates them that way and requires them to stay links:
--   * do_link_queries (install.lua) replaces an entry with uv_unlink(entry)
--     + uv_symlink(...).  uv_unlink cannot remove a real directory (EPERM on
--     windows, EISDIR on unix), that error is discarded, and the symlink then
--     fails with EEXIST -- the parser update reports a failure and is never
--     retried, because its revision file was already bumped before the
--     queries step.
--   * needs_update (install.lua) uses "entry resolves to the same place as
--     the shipped queries" as the up-to-date condition for languages without
--     a pinned revision.
-- So copies cannot work and the entries stay links; only their target is
-- repaired here, because it is absolute on windows and dangles once the
-- install dir moves (on unix the relative target survives the move untouched).

local is_win = vim.uv.os_uname().sysname == 'Windows_NT'
-- marks the query copies made before the switch back to links
local legacy_marker = '.sync_stamp'

-- remove a symlink, a junction or a whole directory tree (as install.lua rmpath)
local function rmpath(path)
    local lstat = vim.uv.fs_lstat(path)
    if not lstat then return end
    if lstat.type == 'directory' then
        for f in vim.fs.dir(path) do rmpath(path .. '/' .. f) end
        vim.uv.fs_rmdir(path)
    else -- 'link' (symlink/junction) or regular file
        vim.uv.fs_unlink(path)
    end
end

--- Make every queries entry resolve to the shipped queries again.
--- Called at the start of M.setup and on User TSUpdate (see M.setup).
---@param dir? string install dir, defaults to the configured one
function M.sync_query_links(dir)
    local queries_dir = (dir or install_dir) .. '/queries'
    if not vim.uv.fs_stat(queries_dir) then return end
    local src_root = vim.fs.dirname(queries_dir) .. '/runtime/queries'

    ---@param name string language
    local function repair(name)
        local src = src_root .. '/' .. name
        local dst = queries_dir .. '/' .. name
        if not vim.uv.fs_stat(src) then return end -- nothing shipped: plugin-managed entry
        local lstat = vim.uv.fs_lstat(dst)
        if not lstat then return end -- never create entries: get_installed() lists this dir,
        -- and a link without an installed parser would make the language look installed
        if lstat.type == 'link' then
            if vim.uv.fs_realpath(dst) == vim.uv.fs_realpath(src) then return end -- already correct
        elseif not vim.uv.fs_stat(dst .. '/' .. legacy_marker) then
            return -- a real directory the plugin owns (do_copy_queries); leave it alone
        end
        rmpath(dst)
        vim.uv.fs_symlink(
            is_win and vim.fs.normalize(src) or ('../runtime/queries/' .. name),
            dst,
            { dir = true, junction = true }
        )
    end

    -- snapshot the names first: entries get replaced while iterating
    local names = {}
    for name in vim.fs.dir(queries_dir) do
        names[#names + 1] = name
    end
    for _, name in ipairs(names) do
        repair(name)
    end
end

------------------------------------------------------------------------ setup

function M.setup()
    -- repair the queries links first: install() below (and every later :TS
    -- command) assumes those entries are links to the shipped queries
    M.sync_query_links()

    if is_win then
        vim.env.CC = "gcc"
    end

    local install_lang = {}
    -- vim.env.http_proxy = "http://127.0.0.1:1080"
    -- vim.env.https_proxy = "http://127.0.0.1:1080"
    -- install_lang = { "c", "lua", "vim", "vimdoc", "query", "bash", "markdown", "markdown_inline", "cpp", "python", "make", "cmake", "cuda" }

    require("nvim-treesitter").setup({
        install_dir = install_dir, -- already in runtimepath
    })

    require("nvim-treesitter").install(install_lang)

    -- Mid-session fallback for the links: the plugin fires this at the START of
    -- TSInstall/TSUpdate/TSUninstall (install.lua reload_parsers, called
    -- synchronously from install() above).  Real care is taken at startup.
    vim.api.nvim_create_autocmd('User', {
        pattern = 'TSUpdate',
        callback = function() M.sync_query_links() end,
        desc = "keep nvim-treesitter queries links pointing at the shipped queries",
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

return M
