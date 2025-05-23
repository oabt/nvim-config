local picker_config = {
enabled = true,

db = {
    sqlite3_path = "",
},

prompt = "",

focus = "input",

layout = {

    cycle = false,
    -- preview = false,

    layout = {
        backdrop = false,
        row = 1,
        width = 0.5,
        min_width = 80,
        height = 0.95,
        border = "none",
        box = "vertical",
        { win = "preview", title = "{preview}", height = 0.5, border = "rounded" },
        {
            box = "vertical",
            border = "rounded",
            title = "{title} {live} {flags}",
            title_pos = "center",
            { win = "input", height = 1, border = "bottom" },
            { win = "list", border = "none" },
        },
    },
},

win = {
    input = {
        keys = {
            -- to close the picker on ESC instead of going to normal mode,
            -- add the following keymap to your config

            ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["<C-c>"] = { "close", mode = { "n", "i" }},

            ["<CR>"] = { "confirm", mode = { "n", "i" } },
            ["<S-CR>"] = { { "pick_win", "jump" } },
            ["<c-o>"] = { "confirm", mode = { "n", "i" } },
            ["<c-s>"] = { "edit_split", mode = { "i", "n" } },
            ["s"] = { "edit_split", mode = { "n" } },
            ["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
            ["v"] = { "edit_vsplit", mode = { "n" } },
            ["<c-t>"] = { "tab", mode = { "n", "i" } },
            ["t"] = { "tab", mode = { "n" } },
            ["T"] = { "tabdrop", mode = { "n" } },

            ["<c-p>"] = { "list_up", mode = { "i", "n" } },
            ["<c-n>"] = { "list_down", mode = { "i", "n" } },
            ["<c-k>"] = false,
            ["<c-j>"] = false,

            ["<c-u>"] = { "list_scroll_up", mode = {"n"} },
            ["<c-d>"] = { "list_scroll_down", mode = {"n"} },

            ["<Up>"] = { "history_back", mode = { "i", "n" } },
            ["<Down>"] = { "history_forward", mode = { "i", "n" } },

            ["<c-b>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-f>"] = { "preview_scroll_down", mode = { "i", "n" } },

            ["<c-a>"] = { "select_all", mode = { "n", "i" } },
            ["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
            ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },

            ["<c-w>"] = { "cycle_win", mode = { "i", "n" } },
            ["<a-w>"] = false,
            ["<c-w>H"] = false,
            ["<c-w>J"] = false,
            ["<c-w>K"] = false,
            ["<c-w>L"] = false,
            ["<leader>p"] = { "toggle_preview", mode = { "n" } },
            ["<a-p>"] = false,

            ["<a-d>"] = "inspect",
            ["<a-f>"] = { "toggle_follow", mode = { "i", "n" } },
            ["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
            ["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } },

            ["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
            ["<c-q>"] = false,
            ["?"] = "toggle_help_input",
            ["G"] = "list_bottom",
            ["gg"] = "list_top",
            ["j"] = "list_down",
            ["k"] = "list_up",
            ["q"] = "close",
        },
    },

    list = {
        keys = {
            ["<Esc>"] = "cancel",
            ["q"] = "close",

            ["<2-LeftMouse>"] = "confirm",
            ["<CR>"] = "confirm",
            ["<S-CR>"] = { { "pick_win", "jump" } },
            ["<c-s>"] = "edit_split",
            ["s"] = { "edit_split", mode = { "n" } },
            ["<c-v>"] = "edit_vsplit",
            ["v"] = { "edit_vsplit", mode = { "n" } },
            ["<c-t>"] = "tab",
            ["t"] = { "tab", mode = { "n" } },
            ["T"] = { "tabdrop", mode = { "n" } },

            ["<c-p>"] = "list_up",
            ["<c-n>"] = "list_down",
            ["<Up>"] = "list_up",
            ["<Down>"] = "list_down",
            ["<c-k>"] = false,
            ["<c-j>"] = false,

            ["<c-u>"] = "list_scroll_up",
            ["<c-d>"] = "list_scroll_down",

            ["<c-b>"] = "preview_scroll_up",
            ["<c-f>"] = "preview_scroll_down",

            ["<c-a>"] = "select_all",
            ["<Tab>"] = { "select_and_next", mode = { "n", "x" } },
            ["<S-Tab>"] = { "select_and_prev", mode = { "n", "x" } },

            ["<c-w>"] = { "cycle_win", mode = { "i", "n" } },
            ["<a-w>"] = false,
            ["<c-w>H"] = false,
            ["<c-w>J"] = false,
            ["<c-w>K"] = false,
            ["<c-w>L"] = false,
            ["<leader>p"] = "toggle_preview",
            ["<a-p>"] = false,

            ["<a-d>"] = "inspect",
            ["<a-f>"] = "toggle_follow",
            ["<a-h>"] = "toggle_hidden",
            ["<a-i>"] = "toggle_ignored",
            ["<a-m>"] = "toggle_maximize",

            ["<c-q>"] = false,
            ["?"] = "toggle_help_list",
            ["G"] = "list_bottom",
            ["gg"] = "list_top",
            ["i"] = "focus_input",
            ["j"] = "list_down",
            ["k"] = "list_up",
            ["zb"] = "list_scroll_bottom",
            ["zt"] = "list_scroll_top",
            ["zz"] = "list_scroll_center",
        },
        wo = {
            -- number = true,
        }
    },
    preview = {
        keys = {
            ["<Esc>"] = "cancel",
            ["q"] = "close",
            ["i"] = "focus_input",
            ["<ScrollWheelDown>"] = "list_scroll_wheel_down",
            ["<ScrollWheelUp>"] = "list_scroll_wheel_up",
            ["<c-w>"] = "cycle_win",
            ["<a-w>"] = false,
        },
    },
},

--TODO: how to disable all the icons
icons = nil,

}


-- launch the picker default
vim.keymap.set('n', '<Leader>d',
function()
    require('snacks').picker()
end,
{desc="launch the picker"}
)

-- fuzzy grep in current file/lines
vim.keymap.set('n', '<Leader>f',
function()
    require('snacks').picker.lines()
end,
{desc="fuzzy grep in current buffer lines"}
)

-- finding old files
vim.keymap.set('n', '<C-p>',
function()
    require('snacks').picker.recent()
end,
{desc="finding old files through picker"}
)

-- fuzzy grep in current file/lines
vim.keymap.set('n', 'f<C-p>',
function()
    require('snacks').picker.files({
        -- cmd = "rg",
        dirs = {"."},
        hidden = true,
        ignored = true,
        title = "Files in ./",
    })
end
)

vim.keymap.set('n', 'ff<C-p>',
function()
    require('snacks').picker.files({
        -- cmd = "rg",
        dirs = {".."},
        hidden = true,
        ignored = true,
        title = "Files in ../",
    })
end
)

-- function for typing string or using word under cursor for grep
local function input_string_for_grep()
    local input_str = ""
    local aborted = false
    vim.ui.input(
        {
            prompt = 'String to search ("' ..
                vim.fn.expand("<cword>") ..
                '" under cursor in default): ',

            default = nil,
            -- completion = 'file', -- TODO: not working with nvim-cmp
        },
        function(input)
            if type(input) == 'nil' then -- input is aborted
                aborted = true
            else
                if string.len(input) == 0 then
                    input_str = vim.fn.expand("<cword>")
                else
                    input_str = input
                end
            end
        end
    )
    if aborted then return nil end
    return input_str
end

vim.keymap.set('n', '<Leader>a',
function()
    local input_str = input_string_for_grep()
    if type(input_str) == 'nil' then
        -- do nothing since the input was aborted
    else
        require('snacks').picker.grep({
            search = input_str,
            live = false,
            supports_live = true,
            dirs = {"."},
            title = "Grep in ./"
        })
    end
end,
{desc="grep string in ./ (and opend buffers)"}
)

vim.keymap.set('n', 'f<Leader>a',
function()
    local input_str = input_string_for_grep()
    if type(input_str) == 'nil' then
        -- do nothing since the input was aborted
    else
        require('snacks').picker.grep({
            search = input_str,
            live = false,
            supports_live = true,
            dirs = {".."},
            title = "Grep in ../"
        })
    end
end,
{desc="grep string in ../ (and opend buffers)"}
)

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
    matcher = { sort_empty = false, fuzzy = false },
    config = function(opts)
        return require("snacks.picker.source.explorer").setup(opts)
    end,
    win = {
        list = {
            keys = {
                ["u"] = "explorer_up",
                ["o"] = "confirm",
                ["s"] = "edit_split",
                ["v"] = "edit_vsplit",
                ["t"] = "tab",
                ["T"] = "tabdrop",
                ["x"] = "explorer_close", -- close directory
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

return picker_config
