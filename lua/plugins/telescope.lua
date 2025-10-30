-- Telescope:
return {
    link = { src ='nvim-telescope/telescope.nvim', version = '0.1.8'},
    config = function()
        return require('telescope').setup({
            defaults = {
                layout_strategy = "vertical",
            }
        }) -- Setup table
    end
}
