---snacks.statuscolumn.Config
---left snacks.statuscolumn.Components
---right snacks.statuscolumn.Components
---enabled? boolean
local statuscolumn_config = {

left = { "mark", "sign" }, -- priority of signs on the left (high to low)
right = { "fold", "git" }, -- priority of signs on the right (high to low)
folds = {
    open = false, -- show open fold icons
    git_hl = false, -- use Git Signs hl for fold icons
},
git = {
    -- patterns to match Git signs
    patterns = { "GitSign", "MiniDiffSign" },
},
refresh = 100, -- refresh at most every 50ms

}

return statuscolumn_config
