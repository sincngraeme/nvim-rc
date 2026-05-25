vim.lsp.enable({
    "clangd",
    "lua_ls"
})

-- LSP related settings
vim.opt.pumheight = 10
vim.opt.signcolumn = 'yes'
vim.diagnostic.config({
    signs = {
        text = {
            -- [vim.diagnostic.severity.ERROR] = '',
            -- [vim.diagnostic.severity.WARN] = '',
            -- [vim.diagnostic.severity.HINT] = '⚑',
            -- [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.ERROR] = 'E',
            [vim.diagnostic.severity.WARN] = 'W',
            [vim.diagnostic.severity.HINT] = 'H',
            [vim.diagnostic.severity.INFO] = 'I',
        },
    },
})

-- completion options
vim.opt.complete:append('o')
vim.opt.completeopt = { "menuone", "noselect", "popup"}


-- Enabling features only when there is an active LSP in the buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
    callback = function(event)
        local opts = {buffer = event.buf}
        -- vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
        -- vim.keymap.set('n', 'grt', function() vim.lsp.buf.type_definition() end, opts)
        -- vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
        -- vim.keymap.set('n', 'gri', function() vim.lsp.buf.implementation() end, opts)
        vim.keymap.set({'n', 'v'}, '<leader>k', function() vim.lsp.buf.hover() end, opts)
        -- vim.keymap.set('n', 'gO', function() vim.lsp.buf.workspace_symbol() end, opts)
        -- vim.keymap.set('n', '<C-w><C-d>', function() vim.diagnostic.open_float() end, opts)
        -- vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ wrap = true, count = 1 }) end, opts)
        -- vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ wrap = true, count = -1 }) end, opts)
        -- vim.keymap.set('n', 'gra', function() vim.lsp.buf.code_action() end, opts)
        -- vim.keymap.set('n', 'grr', function() vim.lsp.buf.references() end, opts)
        vim.keymap.set('n', 'grf', function() vim.lsp.buf.format({async = true}) end, opts)
        -- vim.keymap.set('n', 'grn', function() vim.lsp.buf.rename() end, opts)
        -- vim.keymap.set('i', '<C-s>', function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set('i', '<C-x><C-o>', function() vim.lsp.completion.get() end, opts)

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
        end
        vim.api.nvim_buf_set_option(event.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    end,
})
