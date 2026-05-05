vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })

require('fidget').setup({
    notification = {
        poll_rate = 10,
        filter = vim.log.levels.INFO,
        override_vim_notify = true,
    },
    integration = {
        ["nvim-tree"] = {
            enable = true,
        },
    },
    logger = {
        level = vim.log.levels.WARN,
    },
})
