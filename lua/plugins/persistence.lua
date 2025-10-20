return {
    link = "folke/persistence.nvim",
    config = function()
        return require('persistence').setup({
            -- add any custom options here
        })   
    end
}
