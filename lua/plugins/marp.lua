return {
    link = "mpas/marp-nvim",
    config = function()
        return require("marp").setup({
            -- port = 8080,
            wait_for_response_timeout = 10,
            wait_for_response_delay = 1,
        })
    end,
}
