return {
    link = "rebelot/kanagawa.nvim",
    config = function()
        require("kanagawa").setup({
            transparent = vim.g.bg_transparency,
            colors = {
                theme = {
                    wave = {
                        ui = {
                            bg_gutter = "none"
                        }
                    }
                }
            },
            overrides = function(colors)
                return {}
            end,
        })
    end,
}
