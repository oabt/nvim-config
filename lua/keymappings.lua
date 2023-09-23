-- general keymap settings

local keymap = vim.keymap.set

vim.g.mapleader = ' '

keymap('n', 'j', 'gj', {remap=false})
keymap('n', 'k', 'gk', {remap=false})
keymap('n', 'gj', 'j', {remap=false})
keymap('n', 'gk', 'k', {remap=false})

keymap('i', 'fd', '<Esc><Esc><Right>')

keymap('n', '<Leader>w', '<cmd>w<cr>')
keymap('n', '<Leader>/', '<cmd>nohlsearch<cr>')

-- should be moved to plugin settings
keymap('n', ';t', '<cmd>tabnew<cr><cmd>Startify<cr>')

keymap('n', '<F2>',
    function()
        if vim.bo.filetype ~= 'startify' or vim.fn.winnr('$') > 1 then
            vim.cmd('tabnew')
        end
        vim.cmd('e $MYVIMRC')
        -- vim.cmd('vs vim-legacy.vim')
    end
)

if vim.loop.os_uname().sysname == 'Windows_NT' then
    keymap('n', 'f<C-f>', '<cmd>silent! !explorer .<cr>')
    keymap('n', '<C-t>', '<cmd>split term://cmd<cr>i')
else if vim.loop.os_uname().sysname == 'Linux' then
    keymap('n', '<C-t>', '<cmd>split term://bash<cr>i') end
end

keymap('t', 'fd', '<C-\\><C-n>', {remap=false})
keymap('t', '<C-w>h', '<C-\\><C-n><C-w>h', {remap=false})
keymap('t', '<C-w>j', '<C-\\><C-n><C-w>j', {remap=false})
keymap('t', '<C-w>k', '<C-\\><C-n><C-w>k', {remap=false})
keymap('t', '<C-w>l', '<C-\\><C-n><C-w>l', {remap=false})
keymap('t', '<C-w>H', '<C-\\><C-n><C-w>Hi', {remap=false})
keymap('t', '<C-w>J', '<C-\\><C-n><C-w>Ji', {remap=false})
keymap('t', '<C-w>K', '<C-\\><C-n><C-w>Ki', {remap=false})
keymap('t', '<C-w>L', '<C-\\><C-n><C-w>Li', {remap=false})
keymap('t', '<C-w>T', '<C-\\><C-n><C-w>Ti', {remap=false})

keymap({'n', 'v'}, 'fh', '20h')
keymap({'n', 'v'}, 'fj', '20j')
keymap({'n', 'v'}, 'fk', '20k')
keymap({'n', 'v'}, 'fl', '20l')
keymap({'n', 'v'}, 'fzl', '20zl')
keymap({'n', 'v'}, 'fzh', '20zh')

keymap('i', '<M-h>', '<Left>', {remap=false})
keymap('i', '<M-l>', '<Right>', {remap=false})
keymap('i', '<M-j>', '<Down>', {remap=false})
keymap('i', '<M-k>', '<Up>', {remap=false})

keymap({'n', 'v'}, '<C-l>', '7zl', {remap=false})
keymap({'n', 'v'}, '<C-h>', '7zh', {remap=false})

keymap('n', 'Q', '<cmd>q<cr>', {remap=false})
keymap('n', ';;l', 'gt', {remap=false})
keymap('n', ';;h', 'gT', {remap=false})
keymap('n', ';h', '<C-w>h', {remap=false})
keymap('n', ';j', '<C-w>j', {remap=false})
keymap('n', ';k', '<C-w>k', {remap=false})
keymap('n', ';l', '<C-w>l', {remap=false})

keymap('n', "1t", "<cmd>1tabn<cr>", {remap=false})
keymap('n', "2t", "<cmd>2tabn<cr>", {remap=false})
keymap('n', "3t", "<cmd>3tabn<cr>", {remap=false})
keymap('n', "4t", "<cmd>4tabn<cr>", {remap=false})
keymap('n', "5t", "<cmd>5tabn<cr>", {remap=false})
keymap('n', "6t", "<cmd>6tabn<cr>", {remap=false})
keymap('n', "7t", "<cmd>7tabn<cr>", {remap=false})
keymap('n', "8t", "<cmd>8tabn<cr>", {remap=false})
keymap('n', "9t", "<cmd>9tabn<cr>", {remap=false})

keymap('n', "<M-l>", "2<C-w>>", {remap=false})
keymap('n', "<M-h>", '2<C-w><', {remap=false})
keymap('n', "<M-k>", "<C-w>+", {remap=false})
keymap('n', "<M-j>", "<C-w>-", {remap=false})

keymap('n', "<C-Left>", "<cmd>tabprevious<CR>")
keymap('n', "<C-Right>", "<cmd>tabnext<CR>")


