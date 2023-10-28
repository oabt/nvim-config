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
                -- ["<Cr>"] = {"<Esc>", type = "command"},
                ["<C-u>"] = false,
                ["<C-c>"] = actions.close,
                ["<Cr>"] = actions.select_default,
                ["<C-o>"] = actions.select_default,
                ["<C-v>"] = actions.select_vertical,
                ["<C-s>"] = actions.select_horizontal,
                ["<C-t>"] = actions.select_tab,
            },
            n = {
                ["i"] = {"i<Right>", type = "command"},
                ["o"] = actions.select_default,
                ["v"] = actions.select_vertical,
                ["s"] = actions.select_horizontal,
                ["t"] = actions.select_tab,
                ["T"] = {"tgT", type="command", opts={remap=true}},
                ["p"] = require('telescope.actions.layout').toggle_preview,
                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,
                ["q"] = actions.close,
                ["Q"] = actions.close,
                ["<C-c>"] = actions.close,
            }
        },
        layout_strategy = 'center',
        --layout_strategy = 'bottom_pane',
        sorting_strategy = "ascending",
        --winblend = 30, -- transparence of the telescope UI
        layout_config = {
            anchor = "S", -- "S" for South: align to the bottom edge, not working for 'bottom_pane'
            height = 0.5,
            width = 0.5, -- not working for 'bottom_pane' layout
            preview_cutoff = 2,
        },

    },

    pickers = {
        find_files = {
            --find_command = {'rg', '--files', '--no-ignore', '--follow', '--hidden', '--color', 'never'}
            hidden = true,
            no_ignore = true,
            follow = true,
        },
        jumplist = {
            fname_width = 40,
        },
        lsp_references = {
            fname_width = 40,
        },
        lsp_incoming_calls = {
            fname_width = 40,
        },
        lsp_implementations = {
            fname_width = 40,
        },
        lsp_document_symbols = {
            fname_width = 40,
            symbol_width = 40,
            symbol_type_width = 20,
        },
        lsp_workspace_symbols = {
            fname_width = 40,
            symbol_width = 40,
            symbol_type_width = 20,
        },
        lsp_dynamic_workspace_symbols = {
            fname_width = 40,
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
vim.keymap.set('n', '<Leader>d',
    function()
        builtin.builtin({
            --layout_config = theme_layout,
            previewer = false,
        })
    end,
    {desc="launch the telescope builtin"}
)

-- fuzzy grep in current file
vim.keymap.set('n', '<Leader>f', 
    function()
        builtin.current_buffer_fuzzy_find({
            previewer = false,
        })
    end
)

-- finding oldfiles
vim.keymap.set('n', '<C-p>', 
    function()
        builtin.oldfiles({
            previewer = false,
        })
    end,
    {desc="finding oldfiles"}
)

-- finidng files from ./
vim.keymap.set('n', 'f<C-p>',
    function()
        builtin.find_files({
            previewer = false,
            prompt_title = 'Finding files in ./',
            cwd = '.',
        })
    end,
    {desc="finding files from ./"}
)

-- finding files from ../
vim.keymap.set('n', 'ff<C-p>',
    function()
        builtin.find_files({
            previewer = false,
            prompt_title = 'Finding files in ../',
            cwd = '..',
        })
    end,
    {desc="finding files from ../"}
)

-- function for typing string or using word under cursor for grep
local function input_string_for_grep()
    local input_str = ""
    vim.ui.input(
        {
            prompt = 'String to search ("' ..
                vim.fn.expand("<cword>") ..
                '" under cursor in default): ',

            default = nil,
            --completion = 'file', -- TODO: not working with nvim-cmp
        },
        function(input)
            if type(input) == 'nil' then -- input is aborted
                input_str = nil
            else
                if string.len(input) == 0 then
                    input_str = vim.fn.expand("<cword>")
                else
                    input_str = input
                end
            end
        end
    )
    return input_str
end

-- typing the word to be searched in ./
vim.keymap.set('n', '<Leader>a',
    function()
        local input_str = input_string_for_grep()
        if type(input_str) == 'nil' then
            -- do nothing since the input was aborted
        else
            builtin.grep_string({
                previewer = false,
                cwd = './',
                search = input_str,
            })
        end
    end,
    {desc="grep string in ./"}
)

-- typing the word to be searched in ../
vim.keymap.set('n', 'f<Leader>a',
    function()
        local input_str = input_string_for_grep()
        if type(input_str) == 'nil' then
            -- do nothing since the input was aborted
        else
            builtin.grep_string({
                previewer = false,
                cwd = '../',
                search = input_str,
            })
        end
    end,
    {desc="grep string in ../"}
)

-- automatically setlocal number in Telescope preview window
vim.cmd "autocmd User TelescopePreviewerLoaded setlocal number"

