local lualine_config = require('lualine')

--local function is_readonly()
--    local buf = vim.api.nvim_win_get_buf(0)
--    if vim.bo[buf].readonly then
--        return [[]]
--    else
--        return [[]]
--    end
--end
--

local function oabt_macro()
    local macro = vim.fn.reg_recording()
    if macro == '' then
        return ''
    else
        return 'recording @' .. macro
    end
end

local function exist_devicons()
    if package.loaded['nvim-web-devicons'] == nil then
        return false
    else
        return true
    end
end

local function oabt_component_separators()
    if exist_devicons() then
        return { left = '', right = ''}
    else
        return { left = '│', right = '│'}
    end
end

local function oabt_section_separators()
    if exist_devicons() then
        return { left = '', right = ''}
    else
        return { left = '', right = ''}
    end
end

local function oabt_modified_icon()
    if exist_devicons() then
        return '' -- f111
    else
        return '[+]'
    end
end

local function oabt_readonly_icon()
    if exist_devicons() then
        return ''
    else
        return '[-]'
    end
end

-- listen lsp-progress event and refresh lualine
vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
    group = "lualine_augroup",
    pattern = "LspProgressStatusUpdated",
    callback = require("lualine").refresh,
})

lualine_config.setup({
    options = {
        icons_enabled = exist_devicons(),
        theme = 'powerline',
        component_separators = oabt_component_separators(),
        section_separators = oabt_section_separators(),
        disabled_filetypes = {
            statusline = {
                --'NvimTree', -- using lualine nvim-tree extension
                'startify',
            },
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },

    ---------------------------active buffer line section-------------------------
    sections = {
        lualine_a = {
            {'mode',
                fmt = function(str) -- show only the first letter when winwidth is small
                    if vim.fn.winwidth(0) < 70 and vim.o.laststatus < 3 then
                        return str:sub(1,1)
                    else
                        return str
                    end
                end
            },
        },
        lualine_b = {
            {'branch',
                icon='',
                fmt = function(str) -- show only the first letter when winwidth is small
                    if vim.fn.winwidth(0) < 60 and string.len(str) > 2 and vim.o.laststatus < 3 then
                        return '..'
                    else
                        return str
                    end
                end
            },
            {'filename',
                path = 1, --0: only filename, 1: relative path, 2:absolute path
                shorting_target = 40,
                symbols = {
                    modified = oabt_modified_icon(),      -- Text to show when the file is modified.
                    readonly = oabt_readonly_icon(),      -- Text to show when the file is non-modifiable or readonly.
                    unnamed = '[No Name]', -- Text to show for unnamed buffers.
                    newfile = '[New]',     -- Text to show for newly created file before first write
                },
                color = function(section)
                    if vim.bo.modified then
                        return {fg = '#e6db74', gui='italic,bold'}
                    else
                        return nil
                    end
                end,
            },
            {'filetype',
                fmt = function(str) -- hide the filetype when winwidth is small
                    if vim.fn.winwidth(0) < 50 and vim.o.laststatus < 3 then
                        return ''
                    else
                        return str
                    end
                end
            },
        },
        lualine_c = {
            {'diff',
                separator = '│'
            },
            {'diagnostics',
                diagnostics_color = {
                    error = 'DiagnosticSignError',
                    warn = 'DiagnosticSignWarn',
                    info = 'DiagnosticSignInfo',
                    hint = 'DiagnosticSignHint',
                },
                symbols = {
                    error = exist_devicons() and ':' or 'E:',
                    warn = exist_devicons() and ':' or 'W:',
                    info = exist_devicons() and '󰋽:' or 'I:',
                    hint = exist_devicons() and '󰌶:' or 'H:',
                },
                always_visible = true,
            },
        },
        -- lualine_c = {'diff'},

        lualine_x = {
            {'%S', -- not enabled yet: need to set vim.opt.showcmdloc = 'laststatus'
                separator = '',
            },
            {oabt_macro,
                separator = '│',
            },
            {'searchcount',
                separator = '│',
                fmt = function(str)
                    if exist_devicons() and string.len(str) > 0 then
                        return ':' .. str:sub(2,-2)
                    else
                        return str
                    end
                end,
            },
            {'selectioncount',
                separator = '│',
                fmt = function(str)
                    if exist_devicons() and string.len(str) > 0 then
                        return ':' .. str
                    else
                        return str
                    end
                end,
            },
            { require('lsp-progress').progress,
                separator = '│',
            },
        },
        lualine_y = {
            {'encoding',
                separator = '',
                fmt = function(str)
                    if vim.fn.winwidth(0) < 70 and vim.o.laststatus < 3 then
                        return ''
                    else
                        return str
                    end
                end
            },
            'fileformat',
        },

        --lualine_z = {'progress', 'location'}
        --lualine_z = {{'%1p%%  %2l:%-2v'}}
        lualine_z = {{'%1p%% %2l:%-2v',
                fmt = function(str)
                    if vim.fn.winwidth(0) < 70 and vim.o.laststatus < 3 then
                        return str:sub(7)
                    else
                        return str
                    end
                end
        }},
    },

    ---------------------------inactive buffer line section-------------------------
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            {'filename',
                path = 1, --0: only filename, 1: relative path, 2:absolute path
                symbols = {
                    modified = oabt_modified_icon(),      -- Text to show when the file is modified.
                    readonly = oabt_readonly_icon(),      -- Text to show when the file is non-modifiable or readonly.
                    unnamed = '[No Name]', -- Text to show for unnamed buffers.
                    newfile = '[New]',     -- Text to show for newly created file before first write
                },
                color = function(section)
                    if vim.bo.modified then
                        return {fg = '#e6db74', gui='italic,bold'}
                    else
                        return 'lualine_c_inactive'
                    end
                end,
            }
        },
        --lualine_x = {{'%1p%%  %2l:%-2v'}},
        lualine_x = {{'%1p%% %2l:%-2v'}},
        lualine_y = {},
        lualine_z = {}
    },

    tabline = {
    },
    winbar = {
    },
    inactive_winbar = {
    },
    extensions = {
        'nvim-tree',
        'neo-tree',
        'nvim-dap-ui',
    }

})

-- @oabt: setup the buffertag
require('buffertag').setup()

--let g:lightline.separator = { 'left': '', 'right': '' }
--let g:lightline.subseparator = { 'left': '', 'right': '' }
--let g:lightline.component.lineinfo = '%1p%%  %2l:%-2v'
