-- general keymap settings

local keymap = vim.keymap.set
local os_uname = vim.loop.os_uname().sysname

-- using <Space> as the leader key
vim.g.mapleader = ' '

-- motion in normal mode
keymap('n', 'j', 'gj', {remap=false})
keymap('n', 'k', 'gk', {remap=false})
keymap('n', 'gj', 'j', {remap=false})
keymap('n', 'gk', 'k', {remap=false})

-- shortcut for esacpe insert mode
keymap('i', 'fd', '<Esc><Esc><Right>')

keymap('n', '<Leader>w', '<cmd>w<cr>')
keymap('n', '<Leader>/', '<cmd>nohlsearch<cr>')

-- should be moved to plugin settings
keymap('n', ';t', '<cmd>tabnew<cr><cmd>Startify<cr>')

if os_uname == 'Windows_NT' then
    keymap('n', 'f<C-f>', '<cmd>silent! !explorer .<cr>')
    keymap('n', '<C-t>', '<cmd>split term://cmd<cr>i')
else if os_uname == 'Linux' then
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

local function Compile() -- compile or pre-process the current file
    vim.cmd("w")
    if vim.bo.filetype == 'c' then
        if os_uname == 'Windows_NT' then
            vim.cmd("AsyncRun clang % -g -Wall -o %:r.exe")
        elseif os_uname == 'Linux' then
            vim.cmd("AsyncRun gcc % -g -Wall -o %:r.run")
        end
    elseif vim.bo.filetype == 'cpp' then
        if os_uname == 'Windows_NT' then
            vim.cmd("AsyncRun clang++ % -g -Wall -o %:r.exe")
        elseif os_uname == 'Linux' then
            vim.cmd("AsyncRun g++ % -g -Wall -o %:r.run")
        end
    elseif vim.bo.filetype == 'verilog' then
        vim.cmd("AsyncRun iverilog -Wall -o %:r.vvp %")
    elseif vim.bo.filetype == 'python' then
        vim.cmd("AsyncRun flake8 %")
    elseif vim.bo.filetype == 'tex' then
        vim.cmd(
            "AsyncRun xelatex % -job-name=output -output-directory=out -file-line-error" ..
            " -synctex=-1 -interaction=nonstopmode" ..
            " && copy out\\output.pdf %:r.pdf"
        )
    elseif vim.bo.filetype == 'autohotkey' then
        if os_uname == 'Windows_NT' then
            vim.cmd("AsyncRun Ahk2Exe /in % /out %:r.exe")
        end
    end
end

local function Run()
    if vim.bo.filetype == 'c' then
        if os_uname == 'Windows_NT' then
            vim.cmd("split term://%:r.exe")
        elseif os_uname == 'Linux' then
            vim.cmd("split term:// ./%:r.run")
        end
        vim.cmd("startinsert")
    elseif vim.bo.filetype == 'cpp' then
        if os_uname == 'Windows_NT' then
            vim.cmd("split term://%:r.exe")
        elseif os_uname == 'Linux' then
            vim.cmd("split term:// ./%:r.run")
        end
        vim.cmd("startinsert")
    elseif vim.bo.filetype == 'verilog' then
        vim.cmd("split term://vvp %:r.vvp")
        vim.cmd("startinsert")
    elseif vim.bo.filetype == 'tcl' then
        vim.cmd("w")
        vim.cmd("split term://tclsh %")
        vim.cmd("startinsert")
    elseif vim.bo.filetype == 'python' then
		vim.cmd("w")
        vim.cmd("split term://python %")
        vim.cmd("startinsert")
    elseif vim.bo.filetype == 'matlab' then
		vim.cmd("w")
        vim.cmd("AsyncRun matlab -nodesktop -nosplash -r \"try, run(which('%')), end\" ")
    elseif vim.bo.filetype == 'tex' then
        vim.cmd("AsyncRun start %:r.pdf")
    elseif vim.bo.filetype == 'autohotkey' then
        if os_uname == 'Windows_NT' then
            vim.cmd("w")
            vim.cmd("AsyncRun start AutoHotkeyU64 % &")
        end
    end
end

local function DeleteInactiveBufs()
    local tablist = {}
    -- appending the buf No. appering in each tab
    for tab = 1, vim.fn.tabpagenr("$") do
        for k,v in pairs(vim.fn.tabpagebuflist(tab)) do
            tablist[#tablist + 1] = v
        end
    end

    local nWipeouts = 0
    for buf = 1, vim.fn.bufnr("$") do
        -- if the buffer exist in any tabs
        local not_in_tabs = true
        for k, v in pairs(tablist) do
            if buf == v then
                not_in_tabs = false
                break
            end
        end

        -- if buf No. exists and buf not modified and buf not appears in any tabs, then wipe out
        if vim.fn.bufexists(buf) and vim.fn.getbufvar(buf, "&mod")==0 and not_in_tabs then
            vim.cmd("silent exec 'bwipeout'" .. tostring(buf))
            nWipeouts = nWipeouts + 1
        end
    end
    print(nWipeouts, ' buffer(s) wiped out.')
end

keymap('n', '<F6>', Compile, {desc='execute the Compile function'})
keymap('n', '<F5>', Run, {desc='execute the Run function'})
keymap('n', '<F3>', DeleteInactiveBufs, {desc='delete the unused buffers'})
keymap('n', '<F2>',
    function()
        if vim.bo.filetype ~= 'startify' or vim.fn.winnr('$') > 1 then
            vim.cmd('tabnew')
        end
        vim.cmd('e $MYVIMRC')
        --vim.cmd('vs vim-legacy.vim')
    end
)


