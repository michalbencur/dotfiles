vim.pack.add({ 'https://github.com/nvim-tree/nvim-tree.lua' })
vim.pack.add({ 'https://github.com/nvim-tree/nvim-web-devicons' })

require('nvim-tree').setup({
    view = {
        signcolumn = "yes"
    },
    renderer = {
        icons = {
            git_placement = "signcolumn",
            diagnostics_placement = "signcolumn",
            bookmarks_placement = "signcolumn",
        }
    }
})
