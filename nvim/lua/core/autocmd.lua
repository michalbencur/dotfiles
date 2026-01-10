-- Highlight when yanking
---@diagnostic disable-next-line: param-type-mismatch
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Set Wezterm/Kitty user-var IS_NVIM=true when running and active
vim.api.nvim_create_autocmd({ "VimEnter", "VimResume", "UIEnter" }, {
    group = vim.api.nvim_create_augroup("IS_NVIM_ON", { clear = true }),
    callback = function()
        vim.api.nvim_ui_send("\x1b]1337;SetUserVar=IS_NVIM=dHJ1ZQ==\007")
    end
})
vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
    group = vim.api.nvim_create_augroup("IS_NVIM_OFF", { clear = true }),
    callback = function()
        vim.api.nvim_ui_send("\x1b]1337;SetUserVar=IS_NVIM=ZmFsc2U=\007")
    end
})
