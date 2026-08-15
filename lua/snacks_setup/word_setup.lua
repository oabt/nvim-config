---@class snacks.words.Config
---@field enabled? boolean
local word_config = {
    debounce = 200, -- time in ms to wait before updating
    notify_jump = false, -- show a notification when jumping
    notify_end = true, -- show a notification when reaching the end
    foldopen = true, -- open folds after jumping
    jumplist = true, -- set jump point before jumping
    modes = { "n", "i", "c" }, -- modes to show references
    filter = function(buf) -- what buffers to enable `snacks.words`
        return vim.g.snacks_words ~= false and vim.b[buf].snacks_words ~= false
    end,
}

vim.keymap.set('n', '<M-n>',
function ()
    require('snacks').words.jump(1, true)
end,
{desc = "LSP words cyclic jump forward"}
)

vim.keymap.set('n', '<M-N>',
function ()
    require('snacks').words.jump(-1, true)
end,
{desc = "LSP words cyclic jump backward"}
)

return word_config
