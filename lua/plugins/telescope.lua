-- Telescope:
return {
    link = { src ='nvim-telescope/telescope.nvim', version = 'v0.2.2'},
    config = function()
        return require('telescope').setup({
            defaults = {
                layout_strategy = "horizontal",
                mappings = {
                    i = {
                        ["<C-s>"] = "file_split",
                        ["<C-x>"] = "delete_buffer",
                    }
                },
            }
        }) -- Setup table
    end
}
