local map = vim.keymap.set

-- Navigate panes - used by Wezterm
map('n', '<M-Left>', '<C-w>h', { desc = 'Move left' })
map('n', '<M-Down>', '<C-w>j', { desc = 'Move down' })
map('n', '<M-Up>', '<C-w>k', { desc = 'Move up' })
map('n', '<M-Right>', '<C-w>l', { desc = 'Move right' })

-- Move Lines
map('n', '<M-S-Up>', '<Cmd>move -2<CR>', { desc = 'Move line up' })
map('n', '<M-S-Down>', '<Cmd>move +1<CR>', { desc = 'Move line down' })
map('x', '<M-S-Up>', ":move '<-2<CR>gv", { desc = 'Move selection up' })
map('x', '<M-S-Down>', ":move '>+1<CR>gv", { desc = 'Move selection down' })
map('i', '<M-S-Up>', '<C-o><Cmd>move -2<CR>', { desc = 'Move line up' })
map('i', '<M-S-Down>', '<C-o><Cmd>move +1<CR>', { desc = 'Move line down' })

-- Easier interaction with the system clipboard
map({ 'n', 'x' }, '<Leader>y', '"+y', { desc = '[y]ank to system clipboard (+ register)' })
map({ 'n', 'x' }, '<Leader>p', '"+p', { desc = '[p]aste from system clipboard (+ register) after cursor' })
map({ 'n', 'x' }, '<Leader>P', '"+P', { desc = '[P]aste from system clipboard (+ register) before cursor' })

-- Quickfix/Location List/Diagnostic keymaps
map('n', '<Leader>q', '<Cmd>copen<CR>', { desc = 'Open [q]uickfix list window' })
map('n', '<Leader>ll', '<Cmd>lopen<CR>', { desc = 'Open [l]ocation list window' })
map('n', '<Leader>ld', vim.diagnostic.setloclist, { desc = 'Open [d]iagnostic quickfix list' })

vim.keymap.set('n', '<Leader>f', vim.cmd.NvimTreeToggle, { desc = 'NvimTree toggle' })
vim.keymap.set('n', '<Leader>mm', '<Cmd>Mason<CR>', { desc = 'Open [m]ason [m]enu' })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<Leader><space>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<Leader>/', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<Leader>,', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<Leader>h', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('n', '<Leader>gg', vim.cmd.LazyGit, { desc = 'LazyGit' })
vim.keymap.set('n', '<Leader>gc', builtin.git_bcommits, { desc = 'Telescope current buffer commits' })

-- Custom
vim.keymap.set('n', '<Leader>j', function()
    local location = vim.api.nvim_win_get_cursor(0)
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
        require 'vim.treesitter._select'.select_child(vim.v.count1)
    else
        vim.lsp.buf.selection_range(-vim.v.count1)
    end
    vim.cmd([[noau normal! "vy]])
    local oldEncrypted = vim.fn.getreg("v")
    local output = vim.fn.systemlist("node ~/Desktop/replace-jasypt/reencrypt.mjs " .. oldEncrypted)
    if output == nil then
        vim.notify("Invalid JASYPT", vim.log.levels.ERROR)
    else
        local encrypted = table.concat(output, "\n")
        if encrypted:len() < 2 then
            vim.notify("Invalid JASYPT2", vim.log.levels.ERROR)
        else
            vim.notify("Converted JASYPT", vim.log.levels.INFO)
            vim.cmd(":%s$" .. oldEncrypted .. "$" .. encrypted .. "$g\n")
            vim.api.nvim_win_set_cursor(0, location)
        end
    end
end, { desc = "Jasypt re-encrypt" })
