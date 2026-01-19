vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim.git" })
vim.pack.add({ "https://github.com/nvim-telescope/telescope.nvim.git" })

require('telescope').setup({
    defaults = {
        layout_config = {
            width = 0.9,
            height = 0.9
        },
    }
})
