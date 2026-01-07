local map = vim.keymap.set

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
map('n', '<Leader>l', '<Cmd>lopen<CR>', { desc = 'Open [l]ocation list window' })
map('n', '<Leader>d', vim.diagnostic.setloclist, { desc = 'Open [d]iagnostic quickfix list' })

