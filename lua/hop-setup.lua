local hop_config = require('hop')

local directions = require('hop.hint').HintDirection

hop_config.setup({})

-- mapping of hop

-- Jump to arbitrary char backward (BEFORE_CURSOR) and forward (AFTER_CURSOR)
vim.keymap.set('', '<Leader>es', function()
        hop_config.hint_char1({})
    end, {remap=true}
    )

-- Jump to arbitrary char only backward (BEFORE_CURSOR)
vim.keymap.set('', '<Leader>eF', function()
        hop_config.hint_char1({direction = directions.BEFORE_CURSOR})
    end, {remap=true}
    )

-- Jump to arbitrary char only backward (BEFORE_CURSOR)
vim.keymap.set('', '<Leader>ef', function()
        hop_config.hint_char1({direction = directions.AFTER_CURSOR})
    end, {remap=true}
    )

-- Jump to line upward （before cursor)
vim.keymap.set('', '<Leader>ek', function()
        hop_config.hint_lines({direction = directions.BEFORE_CURSOR})
    end, {remap=true}
    )

-- Jump to line upward （before cursor)
vim.keymap.set('', '<Leader>ej', function()
        hop_config.hint_lines({direction = directions.AFTER_CURSOR})
    end, {remap=true}
    )

-- the default mapping of the vim-easymotion (the <Leader> is replaced by <Leader>e)
   -- Default Mapping      | Details
   -- ---------------------|----------------------------------------------
   -- <Leader>ef{char}     | Find {char} to the right. See |f|.
   -- <Leader>eF{char}     | Find {char} to the left. See |F|.
   -- <Leader>et{char}     | Till before the {char} to the right. See |t|.
   -- <Leader>eT{char}     | Till after the {char} to the left. See |T|.
   -- <Leader>ew           | Beginning of word forward. See |w|.
   -- <Leader>eW           | Beginning of WORD forward. See |W|.
   -- <Leader>eb           | Beginning of word backward. See |b|.
   -- <Leader>eB           | Beginning of WORD backward. See |B|.
   -- <Leader>ee           | End of word forward. See |e|.
   -- <Leader>eE           | End of WORD forward. See |E|.
   -- <Leader>ege          | End of word backward. See |ge|.
   -- <Leader>egE          | End of WORD backward. See |gE|.
   -- <Leader>ej           | Line downward. See |j|.
   -- <Leader>ek           | Line upward. See |k|.
   -- <Leader>en           | Jump to latest "/" or "?" forward. See |n|.
   -- <Leader>eN           | Jump to latest "/" or "?" backward. See |N|.
   -- <Leader>es           | Find(Search) {char} forward and backward.
   --                      | See |f| and |F|.
