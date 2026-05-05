local function select_under_cursor()
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
        require 'vim.treesitter._select'.select_child(vim.v.count1)
    else
        vim.lsp.buf.selection_range(-vim.v.count1)
    end
end

local function get_visual_selection_range()
    local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
    local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
    if csrow < cerow or (csrow == cerow and cscol <= cecol) then
        return csrow - 1, cscol - 1, cerow - 1, cecol
    else
        return cerow - 1, cecol - 1, csrow - 1, cscol
    end
end

local function escape()
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
        "x",
        false
    )
end

local function filter(command)
    local location = vim.api.nvim_win_get_cursor(0)

    select_under_cursor()
    local sr, sc, er, ec = get_visual_selection_range()
    local textTable = vim.api.nvim_buf_get_text(0, sr, sc, er, ec, {})
    local text = table.concat(textTable, "\n")
    vim.notify("text " .. text)
    vim.notify("command " .. command)
    local replacement = vim.fn.systemlist(command .. " " .. text)
    vim.notify("shell_error " .. vim.v.shell_error)
    if vim.v.shell_error > 0 then
        escape()
        vim.notify("Replacer failed" .. vim.v.shell_error, vim.log.levels.ERROR)
        return
    end
    vim.api.nvim_buf_set_text(0, sr, sc, er, ec, replacement)

    vim.api.nvim_win_set_cursor(0, location)
    escape()
    vim.cmd("norm! j")
    vim.notify("Replacer success")
end

vim.api.nvim_create_user_command("ReplacerRun", function(opts)
    filter(opts.args)
end, { desc = "Replace current object with call to command", nargs = 1 })
