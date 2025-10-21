return {
    link = "OXY2DEV/markview.nvim",
    config = function()
	local presets = require("markview.presets")

	return require("markview").setup({
            -- headings = presets.headings.
            horizontal_rules = presets.horizontal_rules.thin
        })
    end,
}
