vim.pack.add({ "https://github.com/catppuccin/nvim" })

require('catppuccin').setup({
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    notify = true,
    lualine = true,
    mason = true,
})

vim.cmd [[colorscheme catppuccin-mocha]]
