local snacks = require('snacks')

local explorer_configs = {explorer = require('snacks_setup.explorer_setup')}
local picker_configs = {picker = require('snacks_setup.picker_setup')}

local snacks_configs = vim.tbl_deep_extend("force", {},

explorer_configs,

picker_configs

)

snacks.setup(snacks_configs)

