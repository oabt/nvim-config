-- lazy install
-- {
--     "nvim-neo-tree/neo-tree.nvim",
--     version = "*",
--     dependencies = {
--       "nvim-lua/plenary.nvim",
--       "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
--       "MunifTanjim/nui.nvim",
--     }
-- }

local neo_tree = require('neo-tree')

local function exist_devicons()
    if package.loaded['nvim-web-devicons'] == nil then
        return false
    else
        return true
    end
end

local neo_tree_icons = {
    expander_collapsed = exist_devicons() and "" or "",
    expander_expanded = exist_devicons() and "" or "",
    folder_closed = exist_devicons() and "" or "+",
    folder_open = exist_devicons() and "" or "-",
    folder_empty = exist_devicons() and "" or "-",
    modified = exist_devicons() and "" or "[+]",

    git_added = "",
    git_modified = "",
    git_deleted = exist_devicons() and "✖" or "x",
    git_renamed = exist_devicons() and "󰁕" or "→",
    git_untracked = exist_devicons() and "" or "?",
    git_ignored = exist_devicons() and "" or "ignored",
    git_unstaged = exist_devicons() and "󰄱" or "unstaged",
    git_staged = exist_devicons() and "" or "staged",
    git_conflict = exist_devicons() and "" or "conflict",
}

require("neo-tree").setup({
    use_default_mappings = false, -- disable all the default key mappings
    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = false,
    enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
    sort_case_insensitive = false, -- used when sorting files and directories in the tree
    sort_function = nil , -- use a custom function for sorting files and directories in the tree 
    -- sort_function = function (a,b)
    --       if a.type == b.type then
    --           return a.path > b.path
    --       else
    --           return a.type > b.type
    --       end
    --   end , -- this sorts files and directories descendantly
    default_component_configs = {
        container = {
            enable_character_fade = true
        },
        indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "┆",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = neo_tree_icons.expander_collapsed,
            expander_expanded = neo_tree_icons.expander_expanded,
            expander_highlight = "NeoTreeExpander",
        },
        icon = {
            folder_closed = neo_tree_icons.folder_closed,
            folder_open = neo_tree_icons.folder_open,
            folder_empty = neo_tree_icons.folder_empty,
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon"
        },
        modified = {
            symbol = neo_tree_icons.modified,
            highlight = "NeoTreeModified",
        },
        name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
        },
        git_status = {
            symbols = {
                -- Change type
                added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                deleted   = neo_tree_icons.git_deleted,-- this can only be used in the git_status source
                renamed   = neo_tree_icons.git_renamed,-- this can only be used in the git_status source
                -- Status type
                untracked = neo_tree_icons.git_untracked,
                ignored   = neo_tree_icons.git_ignored,
                unstaged  = neo_tree_icons.git_unstaged,
                staged    = neo_tree_icons.git_staged,
                conflict  = neo_tree_icons.git_conflict,
            }
        },
        -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
        file_size = {
            enabled = true,
            required_width = 50, -- min width of window required to show this column
        },
        type = {
            enabled = true,
            required_width = 122, -- min width of window required to show this column
        },
        last_modified = {
            enabled = true,
            required_width = 65, -- min width of window required to show this column
        },
        created = {
            enabled = true,
            required_width = 100, -- min width of window required to show this column
        },
        symlink_target = {
            enabled = true,
        },
    },
    -- A list of functions, each representing a global custom command
    -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
    -- see `:h neo-tree-custom-commands-global`
    commands = {},
    window = {
        position = "left",
        width = 30,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
        mappings = {
            -- operations on node
            ["<space>"] = { 
                "toggle_node", 
                nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
            },
            ["q"] = "close_window",
            ["<2-LeftMouse>"] = "open",
            ["<esc>"] = "cancel", -- close preview or floating neo-tree window
            ["<cr>"] = "open",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["x"] = "close_node", -- collapse the dir
            ["X"] = "close_all_nodes", -- collapse all the dirs
            ["o"] = "open",
            ["s"] = "open_split",
            ["v"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["T"] = function(state)
                local node = state.tree:get_node()
                if node.type ~= "directory" then
                    vim.cmd("tabnew " .. node.path)
                    vim.cmd("set signcolumn=auto")
                    vim.cmd("tabprevious")
                end
            end,

            -- FS related operations
            ["ma"] = { 
                "add",
                -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
                -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                config = {
                    show_path = "none" -- "none", "relative", "absolute"
                }
            },
            ["md"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ["DD"] = "delete",
            ["rn"] = "rename",
            ["yy"] = "copy_to_clipboard",
            ["dd"] = "cut_to_clipboard",
            ["pp"] = "paste_from_clipboard",
            ["rn"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["R"] = "refresh",

            -- sorting
            ["O"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "O" }},
            ["Oc"] = { "order_by_created", nowait = false },
            ["Od"] = { "order_by_diagnostics", nowait = false },
            ["Og"] = { "order_by_git_status", nowait = false },
            ["Om"] = { "order_by_modified", nowait = false },
            ["On"] = { "order_by_name", nowait = false },
            ["Os"] = { "order_by_size", nowait = false },
            ["Ot"] = { "order_by_type", nowait = false },

            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
            ["K"] = "show_file_details",
        }
    },
    nesting_rules = {},
    filesystem = {
        bind_to_cwd = true,
        cwd_target = {
            sidebar = "global",
            current = "global",
        },
        filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
                --"node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
                --"*.meta",
                --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
                --".gitignored",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                --".DS_Store",
                --"thumbs.db"
            },
            never_show_by_pattern = { -- uses glob style patterns
                --".null-ls_*",
            },
        },
        follow_current_file = {
            enabled = false, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        group_empty_dirs = false, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
        -- in whatever position is specified in window.position
        -- "open_current",  -- netrw disabled, opening a directory opens within the
        -- window like netrw would, regardless of window.position
        -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
        use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
        -- instead of relying on nvim autocmd events.
        window = {
            mappings = {
                -- ["/"] = "fuzzy_finder",
                -- -- ["D"] = "fuzzy_finder_directory",
                -- ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
                -- -- ["D"] = "fuzzy_sorter_directory",

                -- navigation
                ["u"] = "navigate_up",
                ["cd"] = "set_root",
                ["I"] = "toggle_hidden",
                -- git
                ["[c"] = "prev_git_modified",
                ["]c"] = "next_git_modified",

                -- search and filter
                ["F"] = "filter_on_submit",
                ["<c-x>"] = "clear_filter",

            },
            fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
                ["<down>"] = "move_cursor_down",
                ["<C-n>"] = "move_cursor_down",
                ["<up>"] = "move_cursor_up",
                ["<C-p>"] = "move_cursor_up",
            },
        },

        commands = {} -- Add a custom command or override a global one using the same function name
    },
    buffers = {
        follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        show_unloaded = true,
        window = {
        },
    },
    git_status = {
        window = {
            position = "float",
            -- mappings = {
            --     ["A"]  = "git_add_all",
            --     ["gu"] = "git_unstage_file",
            --     ["ga"] = "git_add_file",
            --     ["gr"] = "git_revert_file",
            --     ["gc"] = "git_commit",
            --     ["gp"] = "git_push",
            --     ["gg"] = "git_commit_and_push",
            -- }
        }
    }
})


vim.keymap.set('n', '<F4>', "<cmd>Neotree left toggle filesystem %:p:h<Cr>", {remap=false})

