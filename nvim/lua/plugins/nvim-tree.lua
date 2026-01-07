vim.pack.add({ 'https://github.com/nvim-tree/nvim-tree.lua' })
vim.pack.add({ 'https://github.com/nvim-tree/nvim-web-devicons' })

require('nvim-tree').setup()

vim.keymap.set('n', '<leader>f', vim.cmd.NvimTreeToggle, { desc = 'NvimTree toggle' })
