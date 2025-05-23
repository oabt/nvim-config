local picker_explorer_config = {
    finder = "explorer",
    sort = { fields = { "sort" } },
    supports_live = true,
    tree = true,
    watch = true,
    diagnostics = false,
    diagnostics_open = false,
    git_status = true,
    git_status_open = false,
    git_untracked = true,
    follow_file = true,
    focus = "list",
    auto_close = false,
    jump = { close = false },
    layout = {
        preview = false,
        layout = {
            backdrop = false,
            width = 40,
            min_width = 40,
            height = 0,
            position = "left",
            border = "none",
            box = "vertical",
            {
                win = "input",
                height = 1,
                border = "rounded",
                title = "{title} {live} {flags}",
                title_pos = "center",
            },
            { win = "list", border = "none" },
            { win = "preview", title = "{preview}", height = 0.4, border = "top" },
        },
    },
    -- to show the explorer to the right, add the below to
    -- your config under `opts.picker.sources.explorer`
    -- layout = { layout = { position = "right" } },
    formatters = {
        file = { filename_only = true },
        severity = { pos = "right" },
    },
    matcher = { sort_empty = false, fuzzy = true },
    config = function(opts)
        return require("snacks.picker.source.explorer").setup(opts)
    end,
    win = {
        list = {
            keys = {
                ["u"] = "explorer_up",
                ["o"] = "confirm",
                ["l"] = false,
                ["s"] = "edit_split",
                ["v"] = "edit_vsplit",
                ["t"] = "tab",
                ["T"] = "tabdrop",
                ["x"] = "explorer_close", -- close directory
                ["h"] = false,
                ["X"] = "explorer_close_all",

                ["ma"] = "explorer_add",
                ["rn"] = "explorer_rename",
                ["c"] = false,
                ["S"] = "explorer_open", -- open with system application
                ["P"] = "toggle_preview",

                ["mv"] = "explorer_move",
                ["m"] = false,

                ["yy"] = { "explorer_yank", mode = { "n", "x" } },
                ["y"] = false,

                ["pp"] = "explorer_paste",
                ["p"] = false,

                ["dd"] = "explorer_del",
                ["d"] = false,

                ["R"] = "explorer_update",
                ["cd"] = "tcd",
                ["<leader>/"] = "picker_grep",
                ["<c-t>"] = "terminal",
                ["."] = "explorer_focus",
                ["I"] = "toggle_ignored",
                ["H"] = "toggle_hidden",
                ["]c"] = "explorer_git_next",
                ["[c"] = "explorer_git_prev",
                ["]d"] = "explorer_diagnostic_next",
                ["[d"] = "explorer_diagnostic_prev",
                ["]w"] = "explorer_warn_next",
                ["[w"] = "explorer_warn_prev",
                ["]e"] = "explorer_error_next",
                ["[e"] = "explorer_error_prev",
            },
        },
    },
}


-- @oabt: try using picker as explorer
vim.keymap.set('n', '<S-F4>',
function()
    require('snacks').picker.explorer(picker_explorer_config)
end
)

vim.api.nvim_create_user_command('PickerExplorer',
function()
    require('snacks').picker.explorer(picker_explorer_config)
end,
{}
)

return picker_explorer_config
