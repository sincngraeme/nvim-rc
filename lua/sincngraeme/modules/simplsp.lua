local M = {}

vim.opt.signcolumn = 'yes'
-- Enabling features only when there is an active LSP in the buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
  callback = function(event)
    local opts = {buffer = event.buf}
    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set({'n', 'v'}, '<leader>k', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '>d', function() vim.diagnostic.jump({ wrap = true, count = 1 }) end, opts)
    vim.keymap.set('n', '<d', function() vim.diagnostic.jump({ wrap = true, count = -1 }) end, opts)
    vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', '<leader>vff', function() vim.lsp.buf.format({async = true}) end, opts)
    vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true, })
    -- vim.api.nvim_buf_set_option(event.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.opt.pumheight = 10
    -- vim.opt.pumwidth = 10
    vim.opt.completeopt = { "menuone", "noselect", "popup"}
    end,
})

-- Configure LSP Clients

-- Default (Will be used for all unless specified otherwise)
vim.lsp.config('*', {
    root_markers = { '.git' },
})

-- Function to iterate over the table and initialize all the LSPs
function M.init(lsp_list)
    local lsp_dir = "lsp"
    local user_input = "y"
    for _, lsp in ipairs(lsp_list) do
        local lsp_path = lsp_dir .. "." .. (lsp.name or lsp)
        local ok, module = pcall(require, lsp_path) -- If the module does not exist don't load
        if ok then
            vim.lsp.config(lsp.executable or lsp, module)
            vim.lsp.enable(lsp.name or lsp)
        end
    end
end

return M
