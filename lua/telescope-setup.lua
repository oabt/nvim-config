local telescope_config = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local picker_theme = require('telescope.themes').get_ivy
local sorters = require('telescope.sorters')

telescope_config.load_extension('fzf')

telescope_config.setup({
    defaults = {
        scroll_strategy = "limit",
        mappings = {
            i = {
                ["<Cr>"] = {"<Esc>", type = "command"},
                ["<C-u>"] = false,
                ["<C-c>"] = actions.close,
            },
            n = {
                ["i"] = {"i<Right>", type = "command"},
                ["o"] = actions.select_default,
                ["v"] = actions.select_vertical,
                ["s"] = actions.select_horizontal,
                ["t"] = actions.select_tab,
                ["p"] = require('telescope.actions.layout').toggle_preview,
                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,
                ["q"] = actions.close,
                ["Q"] = actions.close,
                ["<C-c>"] = actions.close,
            }
        },
        --layout_strategy = 'center',
        layout_strategy = 'bottom_pane',
        sorting_strategy = "ascending",
        --winblend = 30, -- transparence of the telescope UI
        layout_config = {
            height = 0.5,
            width = 0.5, -- not working for 'bottom_pane' layout
        },

    },

    pickers = {
        find_files = {
            --find_command = {'rg', '--files', '--no-ignore', '--follow', '--hidden', '--color', 'never'}
            hidden = true,
            no_ignore = true,
            follow = true,
        }
        --builtin = {
        --    mappings = {
        --        i = {
        --            ["<Cr>"] = actions.select_default,
        --        }
        --    }
        --}
    },

    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
        }
    },
})

------------------------ Key Mappings of telescope

-- launch the telescope builtin
vim.keymap.set('n', '<Leader>d', function()
    builtin.builtin(picker_theme{
        layout_config = theme_layout,
        previewer = false,
    })
end)

-- finding oldfiles
vim.keymap.set('n', '<C-p>', function()
    builtin.oldfiles({
        previewer = false,
    })
end)

-- finidng files from ./
vim.keymap.set('n', 'f<C-p>', function()
    builtin.find_files({
        previewer = false,
        prompt_title = 'Finding files in ./',
        cwd = '.',
    })
end)

-- finding files from ../
vim.keymap.set('n', 'ff<C-p>', function()
    builtin.find_files({
        previewer = false,
        prompt_title = 'Finding file in ../',
        cwd = '..',
    })
end)

-- typing the word to be searched in ./
vim.keymap.set(
    'n', '<Leader>a', ':Telescope grep_string previewer=false search='
)

-- typing the word to be searched in ../
vim.keymap.set(
    'n', 'f<Leader>a', ":Telescope grep_string previewer=false cwd=.. search="
)

-- searching the cursor word in ./
vim.keymap.set('n', '<Leader><Leader>a', function()
    builtin.grep_string({
        previewer = false,
        cwd = './',
    })
end)

-- searching the cursor word in ../
vim.keymap.set('n', 'f<Leader><Leader>a', function()
    builtin.grep_string({
        previewer = false,
        cwd = '../'
    })
end)

