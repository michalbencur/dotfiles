vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim.git" })
vim.pack.add({ "https://github.com/kdheepak/lazygit.nvim" })

require('telescope').load_extension('lazygit')

vim.keymap.set('n', '<leader>g', vim.cmd.LazyGit, { desc = 'LazyGit' })
