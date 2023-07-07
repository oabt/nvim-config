local nvim_tree_config = require('nvim-tree')

local function my_on_attach(bufnr)

    local api = require('nvim-tree.api')

    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    local function tabnew_bg()
        api.node.open.tab()
        vim.cmd('tabprevious')
    end

    -- copy default mappings here from defaults in next section
    --vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node,          opts('CD'))
    --vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))

    ---- OR use all default mappings
    --api.config.mappings.default_on_attach(bufnr)

    -- remove a default
    --vim.keymap.del('n', '<C-]>', { buffer = bufnr })

    -- override a default
    --vim.keymap.set('n', '<C-e>', api.tree.reload,                       opts('Refresh'))

    -- add your mappings
    --vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))

    -- vim edit operations
    vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open: edit'))
    vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: split'))
    vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: vsplit'))
    vim.keymap.set('n', 't', api.node.open.tab, opts('Open: tabnew'))
    vim.keymap.set('n', 'T', tabnew_bg, opts('Open: tabnew'))
    vim.keymap.set('n', 'q', api.tree.close, opts('Close'))

    -- navigation: cd, ls
    vim.keymap.set('n', 'cd', api.tree.change_root_to_node, opts('CD'))
    vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Change root to parent'))
    vim.keymap.set('n', 'x', api.node.navigate.parent_close, opts('collapse the dir'))
    vim.keymap.set('n', 'I', api.tree.toggle_hidden_filter, opts('Toggle hidden files'))
    vim.keymap.set('n', 'K', api.node.show_info_popup, opts('Info'))
    vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
    vim.keymap.set('n', 'X', api.node.run.system, opts('Run system'))

    -- file operation: create, remove, copy, ...
    vim.keymap.set('n', 'ma', api.fs.create, opts('Create new file or directory'))
    vim.keymap.set('n', 'yy', api.fs.copy.node, opts('Copy'))
    vim.keymap.set('n', 'dd', api.fs.cut, opts('Cut'))
    vim.keymap.set('n', 'pp', api.fs.paste, opts('Paste'))
    vim.keymap.set('n', 'DD', api.fs.remove, opts('Delete file or directory'))
    vim.keymap.set('n', 'rn', api.fs.rename, opts('Rename'))

    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))

end

vim.keymap.set('n', '<F4>', ':NvimTreeToggle<Cr>', {remap=false})

local function exist_devicons()
    if package.loaded['nvim-web-devicons'] == nil then
        return false
    else
        return true
    end
end

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        width = 30,
    },
    git = {
        enable = false,
    },
    renderer = {
        full_name = true,
        highlight_modified = 'all',
        icons = {
            show = {
                file = exist_devicons(),
                folder = exist_devicons(),
            },
            glyphs = {
                folder = {
                    arrow_closed = '+',
                    arrow_open = '-',
                }
            }
        },
    },
    filters = {
        dotfiles = true,
    },
    --actions = {
    --    change_dir = {
    --        enable = false,
    --    }
    --},
    respect_buf_cwd = true,
    sync_root_with_cwd = true,

    on_attach = my_on_attach,

})
