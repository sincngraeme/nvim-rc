local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { 'mason-org/mason.nvim',
                    'neovim/nvim-lspconfig'},
    ensure_installed = { 'lua_ls' },
    opts = {
        handlers = {
            function(server_name)
                require('lspconfig')[server_name].setup({
                    capabilities = lsp_capabilities,
                })
            end,
            [ 'lua_ls' ] = function()
                require('lspconfig').lua_ls.setup({
                    capabilities = lsp_capabilities,
                    settings = {
                        Lua = {
                            runtime = { version = 'LuaJIT' },
                            diagnostics = { globals = {"vim"} },
                            workspace = { library = { vim.env.VIMRUNTIME } }
                        }
                    }
                })
            end,
        }
    }
}
