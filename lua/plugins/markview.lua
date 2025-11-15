return {
    link = "OXY2DEV/markview.nvim",
    config = function()
        local presets = require("markview.presets")
        return require("markview").setup({
            markdown = {
                horizontal_rules = presets.horizontal_rules.thin,
                block_quotes = {
                    enable = true,
                    wrap = true,

                    ["ANSWER"] = {
                        hl = "MarkviewBlockQuoteNote",
                        preview = " Answer",

                        title = true,
                        icon = ""
                    },
                    ["SOLUTION"] = {
                        hl = "MarkviewBlockQuoteNote",
                        preview = " Solution",

                        title = true,
                        icon = ""
                    },
                    ["DEFINITION"] = {
                        hl = "MarkviewBlockQuoteNote",
                        preview = " Definition",

                        title = true,
                        icon = ""
                    },
                },
                tables = presets.tables.rounded,
                headings = presets.headings.glow
            },
        })
    end,
}
