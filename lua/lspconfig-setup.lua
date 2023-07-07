--local lsp_installer = require "nvim-lsp-installer"
local lspconfig = require('lspconfig')

lspconfig.pylsp.setup{
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391','E301','E303','E305','E405','E501','W391','F401','E731','E128','E402','E702','F841','E722'},
          maxLineLength = 100
        }
      }
    }
  }
}

lspconfig.clangd.setup{}

vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gD', ':sp | vim.lsp.buf.declaration()<cr>', opts)
            --vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'gd', ':sp | lua vim.lsp.buf.definition()<cr>', opts)
            vim.keymap.set('n', '<C-]>', ':sp | lua vim.lsp.buf.definition()<cr>', opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            --vim.keymap.set('n', '<space>wl', function()
            --    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            --end, opts)
            --vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
            --vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
            --vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
            --vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            --vim.keymap.set('n', '<space>f', function()
            --    vim.lsp.buf.format { async = true }
            --end, opts)
            vim.keymap.set('n', '<Leader>h', vim.diagnostic.goto_prev)
            vim.keymap.set('n', '<Leader>l', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<M-e>', function()
                    if vim.diagnostic.is_disabled() then
                        vim.diagnostic.enable()
                    else
                        vim.diagnostic.disable()
                    end
                end, opts)
        end
    })

local function exist_devicons()
    if package.loaded['nvim-web-devicons'] == nil then
        return false
    else
        return true
    end
end

local function oabt_error_icon()
    if exist_devicons() then
        return "✖"
    else
        return "E"
    end
end

local function oabt_warn_icon()
    if exist_devicons() then
        return ""
    else
        return "W"
    end
end

local signs = {
    {name = "DiagnosticSignError", text = ✖},
    {name = "DiagnosticSignWarn", text = }
}

local diagnostic_config = {
    virtual_text = false,
    update_in_insert = false,
    float = {
        scope = 'buffer'
    }
}

vim.diagnostic.config(diagnostic_config)

-- disable the highlight based on LSP
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
    vim.api.nvim_set_hl(0, group, {})
end

vim.cmd([[sign define DiagnosticSignWarn text=]]
    .. oabt_warn_icon() ..
    [[ texthl=DiagnosticSignWarn linehl= numhl= ]])

vim.cmd([[ sign define DiagnosticSignError text=]]
    .. oabt_error_icon() ..
    [[ texthl=DiagnosticSignError linehl= numhl= ]])

