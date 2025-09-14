return {
    "mason-org/mason.nvim",

    config = function()
        require 'mason'.setup({
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
        })
    end,
}
