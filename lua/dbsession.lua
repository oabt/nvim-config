local uv = vim.loop
local dbs = {}
local loaded_session = "" -- loaded session name

local function iswin()
  return uv.os_uname().sysname == 'Windows_NT'
end

local function path_sep()
  return iswin() and '\\' or '/'
end

local function path_join(...)
  return table.concat({ ... }, path_sep())
end

local function session_list()
    local session_paths = vim.split(vim.fn.globpath(dbs.opt.dir, '*'), '\n')
    return session_paths
end

function dbs.complete_list()
    local list = session_list()
    list = vim.tbl_map(function(k)
        local tbl = vim.split(k, path_sep(), { trimempty = true })
        return vim.fn.fnamemodify(tbl[#tbl], ':r')
    end, list)
    return list
end


local function full_name(session_name)
    return path_join(dbs.opt.dir, session_name)
end

local function session_save(session_name)
    local file_name = ""
    if session_name and #session_name > 0 then
        file_name = session_name
    else
        vim.ui.input(
            {
                prompt = "Input session name: ",
                default = loaded_session,
                copmletion = dbs.complete_list, -- TODO: not working with nvim-cmp
            },
            function(input) file_name = input end
        )
    end
    if (not file_name or #file_name == 0) then
        vim.notify("[SessionSave]: Please input valid session name! Aborted!",
            vim.log.levels.ERROR)
        return
    end

    local list = dbs.complete_list()
    for _, session in ipairs(list) do -- check existed session to overwrite
        if file_name == session then
            vim.notify("\nSession '" .. session .. "' already exists, overwrite? [y/n]",
                vim.log.levels.WARN)
            if vim.fn.getcharstr() == "y" then
                break
            else
                return
            end
        end
    end

    -- clear the unlisted bufs
    local bufinfo_dict = vim.fn.getbufinfo()
    for _, buf_info in pairs(bufinfo_dict) do
        if buf_info['changed'] == 0 and #buf_info['windows'] == 0 then
            vim.api.nvim_buf_delete(buf_info['bufnr'], {force=true})
        end
    end

    loaded_session = file_name
    local file_path = path_join(dbs.opt.dir, file_name)
    vim.api.nvim_command('mksession! ' .. vim.fn.fnameescape(file_path))
    vim.v.this_session = file_path

    vim.notify('[SessionSave]: save as ' .. file_name, vim.log.levels.INFO)
end

local function session_load(session_name)
    local file_path
    if not session_name or #session_name == 0 then
        vim.notify("No such session! Aborted!", vim.log.levels.WARN)
        return
        -- TODO if not session load the latest
        -- local list = session_list()
        -- local sname = default_session_name()
        -- for _, item in ipairs(list) do
        --     if item:find(sname) then
        --         file_path = item
        --         break
        --     end
        -- end
    else
        file_path = full_name(session_name)
    end

    if vim.v.this_session ~= '' and vim.fn.exists('g:SessionLoad') == 0 then
        vim.api.nvim_command('mksession! ' .. vim.fn.fnameescape(vim.v.this_session))
    end

    if vim.fn.filereadable(file_path) == 1 then
        --save before load session
        local curbuf = vim.api.nvim_get_current_buf()
        if vim.bo[curbuf].modified then
            vim.cmd.write()
        end
        vim.cmd([[ noautocmd silent! %bwipeout!]])
        vim.api.nvim_command('silent! source ' .. file_path)
        -- print('[dbsession] load session ' .. file_path)
        loaded_session = session_name
        return
    end

    vim.notify('[SessionLoad] load failed ' .. file_path, vim.log.levels.ERROR)
end

local function session_delete(name)
    if not name or #name == 0 then
        name = loaded_session
    end
    if not name or #name == 0 then
        vim.notify('[SessionDelete] please choice a session to delete', vim.log.levels.WARN)
        return
    end

    local file_path = full_name(name)

    vim.notify("Session '" .. name .. "' will be deleted? [y/n]", vim.log.levels.WARN)
    if vim.fn.getcharstr() ~= "y" then
        return
    end


    if vim.fn.filereadable(file_path) == 1 then
        vim.fn.delete(file_path)
        vim.notify('[SessionDelete] deleted ' .. name, vim.log.levels.INFO)
        return
    end

    vim.notify('[SessionDelete] delete failed ' .. name, vim.log.levels.ERROR)
end

function dbs:command()
    if self.opt.auto_save_on_exit then
        vim.api.nvim_create_autocmd('VimLeavePre', {
            group = vim.api.nvim_create_augroup('session_auto_save', { clear = true }),
            callback = function()
                session_save()
            end,
        })
    end

    vim.api.nvim_create_user_command('SSave', function(opts)
            session_save(opts.args)
        end, {
        nargs = '?',
        complete = dbs.complete_list,
    })

    vim.api.nvim_create_user_command('SLoad', function(opts)
            session_load(opts.args)
        end, {
        nargs = '?',
        complete = dbs.complete_list,
    })

    vim.api.nvim_create_user_command('SDelete', function(opts)
            session_delete(opts.args)
        end, {
        nargs = '?',
        complete = dbs.complete_list,
    })
end

local function default()
    return {
        dir = '~/.nvim/sessions',
        auto_save_on_exit = false,
    }
end

function dbs.setup(opt)
    dbs.opt = vim.tbl_extend('force', default(), opt or {})
    dbs.opt.dir = vim.fs.normalize(dbs.opt.dir)
    if vim.fn.isdirectory(dbs.opt.dir) == 0 then
        vim.fn.mkdir(dbs.opt.dir, 'p')
    end
    dbs:command()
end

return dbs
