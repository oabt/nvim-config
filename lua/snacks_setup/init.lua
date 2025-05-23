local snacks = require('snacks')

local picker_configs = {picker = require('snacks_setup.picker_setup')}

local snacks_configs = vim.tbl_deep_extend("force", {},

picker_configs

)

snacks.setup(snacks_configs)

