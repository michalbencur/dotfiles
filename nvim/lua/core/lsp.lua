vim.lsp.enable('lua_ls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('java_language_server')
vim.lsp.enable('jsonls')
vim.lsp.enable('yamlls')

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local buffer = ev.buf

        if client then
            if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
                vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
                vim.lsp.completion.enable(true, client.id, buffer, { autotrigger = true })
                vim.keymap.set('i', '<C-Space>',
                    function()
                        vim.lsp.completion.get()
                    end,
                    { desc = "Trigger lsp completion" }
                )
            end

            if client:supports_method('textDocument/implementation') then
                vim.keymap.set({ 'i', 'n' }, '<C-d>',
                    function()
                        vim.lsp.buf.implementation()
                    end
                )
            end

            if client:supports_method('textDocument/signatureHelp') then
                vim.keymap.set('n', '<C-s>',
                    function()
                        vim.lsp.buf.signature_help()
                    end,
                    { desc = "Trigger lsp signature help" }
                )
            end

            if client:supports_method('textDocument/formatting') then
                vim.api.nvim_create_autocmd('BufWritePre', {
                    buffer = buffer,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = buffer, id = client.id })
                    end,
                })
            end
        end
    end
})

vim.diagnostic.config({
    virtual_lines = false
})
