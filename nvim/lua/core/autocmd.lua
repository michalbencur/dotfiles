-- Highlight when yanking
---@diagnostic disable-next-line: param-type-mismatch
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- VimEnter Vim LeavePre
-- printf "\033]1337;SetUserVar=%s=%s\007" IS_NVIM `echo -n true | base64`
-- printf "\033]1337;SetUserVar=IS_NVIM=dHJ1ZQ==\007"
-- printf "\033]1337;SetUserVar=IS_NVIM=ZmFsc2U=\007"
