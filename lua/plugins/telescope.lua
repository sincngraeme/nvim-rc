-- Telescope:
return {
    link = { src ='nvim-telescope/telescope.nvim', version = 'v0.2.1'},
    config = function()
        return require('telescope').setup({
            defaults = {
                layout_strategy = "vertical",
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
