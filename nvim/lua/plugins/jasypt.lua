vim.pack.add({ 'https://github.com/michalbencur/jasypt.nvim' })

require('jasypt').setup({
    password = vim.env.JASYPT_PASSWORD,
})
