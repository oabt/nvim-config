local snacks = require('snacks')

local picker_configs = {picker = require('snacks_setup.picker_setup')}
local explorer_configs = {explorer = require('snacks_setup.explorer_setup')}
local dashboard_configs = {dashboard = require('snacks_setup.dashboard_setup')}
local style_configs = {styles = require('snacks_setup.style_setup')}

local snacks_configs = vim.tbl_deep_extend("force", {}

,style_configs

,picker_configs

,explorer_configs

,dashboard_configs


)

snacks.setup(snacks_configs)

