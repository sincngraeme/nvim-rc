return {
    link = "rcarriga/nvim-notify",
    config = function()
        vim.notify = require("notify")
        -- setup
        return vim.notify.setup({
            render = "wrapped-compact",
            level  = 2,
            max_width = 80,
            minimum_width = 50,
            fps = 40,
            stages = "static"

        })
    end
}
