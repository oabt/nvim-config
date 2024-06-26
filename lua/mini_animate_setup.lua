local animate = require('mini.animate')
-- No need to copy this inside `setup()`. Will be used automatically.

local os_uname = vim.uv.os_uname().sysname
local function cursor_duration()
    if os_uname == "Windows_NT" then
        return 25
    elseif os_uname == "Linux" then
        return 125
    end
end
local function scroll_duration()
    if os_uname == "Windows_NT" then
        return 20
    elseif os_uname == "Linux" then
        return 100
    end
end

animate.setup(
{
    -- Cursor path
    cursor = {
        -- Whether to enable this animation
        enable = true,

        -- Timing of animation (how steps will progress in time)
        timing = animate.gen_timing.quadratic({duration=cursor_duration(), unit='total'}),

        -- Path generator for visualized cursor movement
        -- path = --<function: implements shortest line path>,
    },

    -- Vertical scroll
    scroll = {
        -- Whether to enable this animation
        enable = false,

        -- Timing of animation (how steps will progress in time)
        timing = animate.gen_timing.quadratic({duration=scroll_duration(), unit='total'}),

        -- Subscroll generator based on total scroll
        -- subscroll = --<function: implements equal scroll with at most 60 steps>,
    },

    -- Window resize
    resize = {
        -- Whether to enable this animation
        enable = false,

        -- Timing of animation (how steps will progress in time)
        -- timing = --<function: implements linear total 250ms animation duration>,

        -- Subresize generator for all steps of resize animations
        -- subresize = --<function: implements equal linear steps>,
    },

    -- Window open
    open = {
        -- Whether to enable this animation
        enable = false,

        -- Timing of animation (how steps will progress in time)
        -- timing = animate.gen_timing.linear({ duration = 25, unit = 'total' }),

        -- Floating window config generator visualizing specific window
        -- winconfig = animate.gen_winconfig.wipe({ direction = 'from_edge' }),

        -- 'winblend' (window transparency) generator for floating window
        -- winblend = animate.gen_winblend.linear({ from = 80, to = 100 }),
    },

    -- Window close
    close = {
        -- Whether to enable this animation
        enable = false,

        -- Timing of animation (how steps will progress in time)
        -- timing = --<function: implements linear total 250ms animation duration>,

        -- Floating window config generator visualizing specific window
        -- winconfig = --<function: implements static window for 25 steps>,

        -- 'winblend' (window transparency) generator for floating window
        -- winblend = --<function: implements equal linear steps from 80 to 100>,
    },
})

-- modified from https://github.com/edluffy/specs.nvim
local function hint_cursor()
    local start_win_id = vim.api.nvim_get_current_win()

    -- if not M.should_show_specs(start_win_id) then
    --     return
    -- end

    -- if popup == nil then
    --     popup = {}
    -- end

    if not vim.api.nvim_win_is_valid(start_win_id) then
        return
    end

    if vim.fn.getcmdpos() ~= 0 then
        return
    end

    local function oabt_fader(blend, cnt)
        -- linear fader
        if blend + cnt <= 100 then
            return cnt
        else
            return nil
        end
    end

    local function oabt_resizer(width, ccol, cnt)
        -- shrink resizer
        if width-cnt > 0 then
            return {width-cnt, ccol-(width-cnt)/2 + 1}
        else
            return nil
        end
    end

    local opts = {
        show_jumps  = true,
        min_jump = 30,
        popup = {
            delay_ms = 0, -- delay before popup displays
            inc_ms = 25, -- time increments used for fade/resize effects 
            blend = 100, -- starting blend, between 0-100 (fully transparent), see :h winblend
            width = 10,
            winhl = "Cursor",
            fader = oabt_fader,
            resizer = oabt_resizer,
        },
        ignore_filetypes = {},
        ignore_buftypes = {
            nofile = true,
        },
    }

    local _opts = vim.tbl_deep_extend("force", opts, {popup = popup})

    local cursor_col = vim.fn.wincol()-1
    local cursor_row = vim.fn.winline()-1
    local bufh = vim.api.nvim_create_buf(false, true)
    local win_id = vim.api.nvim_open_win(bufh, false, {
        relative= 'win',
        width = 1,
        height = 1,
        col = cursor_col,
        row = cursor_row,
        style = 'minimal'
    })
    vim.api.nvim_set_option_value('winhl', 'Normal:'.._opts.popup.winhl, {win=win_id})
    vim.api.nvim_set_option_value('winblend', _opts.popup.blend, {win=win_id})

    local cnt = 0
    local config = vim.api.nvim_win_get_config(win_id)
    local timer = vim.uv.new_timer()
    local closed = false

    vim.uv.timer_start(timer, _opts.popup.delay_ms, _opts.popup.inc_ms, vim.schedule_wrap(function()
        if closed or vim.api.nvim_get_current_win() ~= start_win_id then
            if not closed then
                pcall(vim.uv.close, timer)
                pcall(vim.api.nvim_win_close, win_id, true)
                pcall(vim.api.nvim_buf_delete, bufh, {force=true})

                -- Callbacks might stack up before the timer actually gets closed, track that state
                -- internally here instead
                closed = true
            end

            return
        end

        if vim.api.nvim_win_is_valid(win_id) then
            local bl = _opts.popup.fader(_opts.popup.blend, cnt)
            local dm = _opts.popup.resizer(_opts.popup.width, cursor_col, cnt)

            if bl ~= nil then
                vim.api.nvim_set_option_value('winblend', bl, {win=win_id})
            end
            if dm ~= nil then
                config["col"] = dm[2]
                vim.api.nvim_win_set_config(win_id, config)
                vim.api.nvim_win_set_width(win_id, dm[1])
            end
            if bl == nil and dm == nil then -- Done blending and resizing
                vim.uv.close(timer)
                vim.api.nvim_win_close(win_id, true)
                vim.api.nvim_buf_delete(bufh, {force=true})
            end
            cnt = cnt+1
        end
    end))
end


vim.api.nvim_create_autocmd( -- automatically change cwd to the file in current buffer
    {"WinEnter"},
    {
        pattern = {"*"},
        callback = function(ev)
            hint_cursor()
        end,
        desc = "hint the cursor position",
    }
)

