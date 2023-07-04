local nvim_web_devicons = require('nvim-web-devicons')

nvim_web_devicons.setup({
    override_by_extension = {
        ["txt"] = {
            icon = "", -- f15c
            color = "#A6E22E",
            name = "txt",
        },
        ["log"] = {
            icon = "", --f4ed
            --color = "#A6E22E",
            name = "Log",
        },
    },
})

