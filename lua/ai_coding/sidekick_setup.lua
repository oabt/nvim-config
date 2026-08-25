local sidekick = require("sidekick")

vim.g.sidekick_nes = false
local cli_name = "claude"
local file_line_sep = '#L'
local file_hint = '@'

sidekick.setup({

  nes = {
    ---@type boolean|fun(buf:integer):boolean?
    enabled = function(buf)
      return vim.g.sidekick_nes ~= false and vim.b.sidekick_nes ~= false
    end,
    debounce = 100,
    trigger = {
      -- events that trigger sidekick next edit suggestions
      events = { "ModeChanged i:n", "TextChanged", "User SidekickNesDone" },
    },
    clear = {
      -- events that clear the current next edit suggestion
      events = { "TextChangedI", "InsertEnter" },
      esc = true, -- clear next edit suggestions when pressing <Esc>
    },
    ---@class sidekick.diff.Opts
    ---@field inline? "words"|"chars"|false Enable inline diffs
    ---@field show? "always"|"cursor" `cursor` will only show the diff when the cursor is at the edit position.
    diff = {
      inline = "words",
      show = "always",
    },
    signs = true, -- show signs for next edit suggestions
    jumplist = true, -- add an entry to the jumplist
  },
  -- Work with AI cli tools directly from within Neovim
  cli = {
    watch = true, -- notify Neovim of file changes done by AI CLI tools
    ---@class sidekick.win.Opts
    win = {
      --- This is run when a new terminal is created, before starting it.
      --- Here you can change window options `terminal.opts`.
      ---@param terminal sidekick.cli.Terminal
      config = function(terminal) end,
      wo = {}, ---@type vim.wo
      bo = {}, ---@type vim.bo
      layout = "right", ---@type "float"|"left"|"bottom"|"top"|"right"
      --- Options used when layout is "float"
      ---@type vim.api.keyset.win_config
      float = {
        width = 0.9,
        height = 0.9,
      },
      -- Options used when layout is "left"|"bottom"|"top"|"right"
      ---@type vim.api.keyset.win_config
      split = {
        width = 80, -- set to 0 for default split width
        height = 20, -- set to 0 for default split height
      },
      --- CLI Tool Keymaps (default mode is `t`)
      ---@type table<string, sidekick.cli.Keymap|false>
      keys = {
        buffers       = { "<c-b>", "buffers"   , mode = "nt", desc = "open buffer picker" },
        files         = { "<c-f>", "files"     , mode = "nt", desc = "open file picker" },
        hide_n        = { "q"    , "hide"      , mode = "n" , desc = "hide the terminal window" },
        hide_ctrl_q   = { "<c-q>", "hide"      , mode = "n" , desc = "hide the terminal window" },
        hide_ctrl_dot = { "<c-.>", "hide"      , mode = "nt", desc = "hide the terminal window" },
        hide_ctrl_z   = { "<c-z>", "blur"      , mode = "nt", desc = "go back to the previous window without hiding the terminal" },
        prompt        = { "<c-p>", "prompt"    , mode = "t" , desc = "insert prompt or context" },
        stopinsert    = { "<c-q>", "stopinsert", mode = "t" , desc = "enter normal mode" },
        -- Navigate windows in terminal mode. Only active when:
        -- * layout is not "float"
        -- * there is another window in the direction
        -- With the default layout of "right", only `<c-h>` will be mapped
        nav_left      = { "<c-h>", "nav_left"  , expr = true, desc = "navigate to the left window" },
        nav_down      = { "<c-j>", "nav_down"  , expr = true, desc = "navigate to the below window" },
        nav_up        = { "<c-k>", "nav_up"    , expr = true, desc = "navigate to the above window" },
        nav_right     = { "<c-l>", "nav_right" , expr = true, desc = "navigate to the right window" },
      },
      ---@type fun(dir:"h"|"j"|"k"|"l")?
      --- Function that handles navigation between windows.
      --- Defaults to `vim.cmd.wincmd`. Used by the `nav_*` keymaps.
      nav = nil,
    },
    ---@class sidekick.cli.Mux
    ---@field backend? "tmux"|"zellij" Multiplexer backend to persist CLI sessions
    mux = {
      backend = vim.env.ZELLIJ and "zellij" or "tmux", -- default to tmux unless zellij is detected
      enabled = false,
      -- terminal: new sessions will be created for each CLI tool and shown in a Neovim terminal
      -- window: when run inside a terminal multiplexer, new sessions will be created in a new tab
      -- split: when run inside a terminal multiplexer, new sessions will be created in a new split
      -- NOTE: zellij only supports `terminal`
      create = "terminal", ---@type "terminal"|"window"|"split"
      split = {
        vertical = true, -- vertical or horizontal split
        size = 0.5, -- size of the split (0-1 for percentage)
      },
    },
    --- Actual cli tool config is loaded from the runtime path `sk/cli/{tool}.lua` and merged with the config below.
    --- For default configs, see https://github.com/folke/sidekick.nvim/tree/main/sk/cli
    ---@type table<string, sidekick.cli.Config|{}>
    tools = {
      aider    = {},
      amazon_q = {},
      claude = {
        -- Command used to start the claude CLI.
        -- Default comes from `sk/cli/claude.lua`: `cmd = { "claude" }` (name resolved from PATH).
        -- Override the executable here when it's not on PATH or you want a specific build:
        -- cmd = { "claude" },                            -- executable name on PATH (default)
        -- cmd = { "D:/Apps/claude-code/bin/claude.exe" }, -- absolute path
        -- cmd = { vim.fn.expand("~/tools/claude.exe") },  -- path with ~ expansion
      },
      codex    = {},
      copilot  = {},
      crush    = {},
      cursor   = {},
      gemini   = {},
      grok     = {},
      opencode = {},
      pi       = {},
      qwen     = {},
    },
    --- Add custom context. See `lua/sidekick/context/init.lua`
    ---@type table<string, sidekick.context.Fn>
    context = {},
    ---@type table<string, sidekick.Prompt|string|fun(ctx:sidekick.context.ctx):(string?)>
    prompts = {
      changes         = "Can you review my changes?",
      diagnostics     = "Can you help me fix the diagnostics in {file}?\n{diagnostics}",
      diagnostics_all = "Can you help me fix these diagnostics?\n{diagnostics_all}",
      document        = "Add documentation to {function|line}",
      explain         = "Explain {this}",
      fix             = "Can you fix {this}?",
      optimize        = "How can {this} be optimized?",
      review          = "Can you review {file} for any issues or improvements?",
      tests           = "Can you write tests for {this}?",
      -- simple context prompts
      buffers         = "{buffers}",
      file            = "{file}",
      line            = "{line}",
      position        = "{position}",
      quickfix        = "{quickfix}",
      selection       = "{selection}",
      ["function"]    = "{function}",
      class           = "{class}",
    },
    -- preferred picker for selecting files
    ---@alias sidekick.picker "snacks"|"telescope"|"fzf-lua"
    picker = "snacks", ---@type sidekick.picker
  },
  copilot = {
    -- track copilot's status with `didChangeStatus`
    status = {
      enabled = true,
      level = vim.log.levels.WARN,
      -- set to vim.log.levels.OFF to disable notifications
      -- level = vim.log.levels.OFF,
    },
  },
  ui = {
    icons = {
      nes               = " ",
      attached          = " ",
      started           = " ",
      installed         = " ",
      missing           = " ",
      external_attached = "󰖩 ",
      external_started  = "󰖪 ",
      terminal_attached = " ",
      terminal_started  = " ",
    },
  },
  debug = false, -- enable debug logging

})


vim.api.nvim_create_user_command("SkCliToggle", function(opts)
    require("sidekick.cli").toggle({name = cli_name, focus=true})
end, {
    desc = "show the cli window",
})

-- Build a file reference like `@file` / `@file#L10` / `@file#L10-20`,
-- with the path relative to the git repo root when the file is inside a git repo,
-- absolute otherwise.
-- line1/line2 are optional: omit them for a file-only reference.
local function buf_ref(line1, line2)
    -- absolute path of the current buffer ("" for unnamed buffers)
    local name = vim.api.nvim_buf_get_name(0)
    if name ~= "" then
        -- find the nearest enclosing git repo, walking up from the buffer's directory
        local git_root = vim.fs.find(".git", { upward = true, path = vim.fs.dirname(name) })[1]
        if git_root then
            -- repo root = dirname of the .git file/dir (also covers worktrees/submodules)
            local rel = vim.fs.relpath(vim.fs.dirname(git_root), name)
            if rel and rel ~= "" then
                name = rel
            end
        end
    end
    local ref = file_hint .. name
    if line1 then
        ref = ref .. ("%s%d"):format(file_line_sep, line1)
        if line2 and line2 > line1 then
            ref = ref .. ("-%d"):format(line2)
        end
    end
    return ref
end

-- Send the context to the Sidekick CLI:
vim.api.nvim_create_user_command("SkSendLine", function(opts)
    require("sidekick.cli").send({ msg = buf_ref(vim.api.nvim_win_get_cursor(0)[1]) })
end, {
    desc = "Send current line to the Sidekick CLI",
})

vim.api.nvim_create_user_command("SkSendFile", function(opts)
    require("sidekick.cli").send({ msg = buf_ref() })
end, {
    desc = "Send current file to the Sidekick CLI",
})

vim.api.nvim_create_user_command("SkSendSelect", function(opts)
    require("sidekick.cli").send({ msg = buf_ref(opts.line1, opts.line2) })
end, {
    range = true,
    desc = "Send file reference with range to the Sidekick CLI",
})



