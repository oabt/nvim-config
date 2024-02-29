
local has_devicons = package.loaded['nvim-web-devicons']

require('lsp-progress').setup({

    -- Format series message.
    --
    -- By default it looks like: `formatting isort (100%) - done`.
    --
    --- @param title string?
    ---     Message title.
    --- @param message string?
    ---     Message body.
    --- @param percentage integer?
    ---     Progress in percentage numbers: 0-100.
    --- @param done boolean
    ---     Indicate whether this series is the last one in progress.
    --- @return lsp_progress.SeriesFormatResult
    ---     The returned value will be passed to function `client_format` as
    ---     one of the `series_messages` array, or ignored if return nil.
    series_format = function(title, message, percentage, done)
        local builder = {}
        local has_title = false
        local has_message = false
        if type(title) == "string" and string.len(title) > 0 then
            table.insert(builder, title)
            has_title = true
        end
        if type(message) == "string" and string.len(message) > 0 then
            table.insert(builder, message)
            has_message = true
        end
        if percentage and (has_title or has_message) then
            table.insert(builder, string.format("(%.0f%%)", percentage))
        end
        if done and (has_title or has_message) then
            table.insert(builder, "- done")
        end
        return table.concat(builder, " ")
    end,

    -- Format client message.
    --
    -- By default it looks like:
    -- `[null-ls] ⣷ formatting isort (100%) - done, formatting black (50%)`.
    --
    --- @param client_name string
    ---     Client name.
    --- @param spinner string
    ---     Spinner icon.
    --- @param series_messages string[]|table[]
    ---     Messages array.
    --- @return lsp_progress.ClientFormatResult
    ---     The returned value will be passed to function `format` as one of the
    ---     `client_messages` array, or ignored if return nil.
    client_format = function(client_name, spinner, series_messages)
        return #series_messages > 0
                and ("[" .. client_name .. "] " .. spinner .. " " .. table.concat(
                    series_messages,
                    ", "
                ))
            or nil
    end,

    -- Format (final) message.
    --
    -- By default it looks like:
    -- ` LSP [null-ls] ⣷ formatting isort (100%) - done, formatting black (50%)`
    --
    --- @param client_messages string[]|table[]
    ---     Client messages array.
    --- @return string
    ---     The returned value will be returned as the result of `progress` API.
    format = function(client_messages)
        -- icon: nf-fa-gear \uf013
        local sign = has_devicons and " LSP" or "LSP"
        if #client_messages > 0 then
            return sign .. " " .. table.concat(client_messages, " ")
        end
        if #vim.lsp.get_active_clients() > 0 then
            return sign
        end
        return ""
    end,
})
