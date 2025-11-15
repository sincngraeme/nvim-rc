return {
    link = "3rd/image.nvim",
    config = function()
        return require("image").setup({
            backend = "kitty",
            processor = "magick_cli",
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = true,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    only_render_image_at_cursor_mode = "popup", -- or "inline"
                    floating_windows = false, -- if true, images will be rendered in floating markdown windows
                    filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
                },
                neorg = { enabled = false, filetypes = { "norg" }, },
                typst = { enabled = false, filetypes = { "typst" }, },
            },
        })
    end
}
