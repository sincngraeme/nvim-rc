return {
	link = "nvim-treesitter/nvim-treesitter",
	-- build = ":TSUpdate",
	config = function()
		local ts_install = require("nvim-treesitter.install")

		-- Set the compiler for Windows compatibility
		ts_install.compilers = {"clang", "gcc", "cl"}  -- Prioritize "clang" or "gcc" before MSVC's "cl"
		ts_install.prefer_git = false

		require('nvim-treesitter.configs').setup {
			-- A list of parser names, or "all" (the listed parsers MUST always be installed)
			ensure_installed = { "c", "cpp", 
                                "javascript", "html", "css",
                                "python", 
                                "lua", 
                                "vim", "vimdoc", 
                                "query", 
                                "markdown", "markdown_inline", "yaml",
                                "typst"
            },

			highlight = {
			  enable = true,
			  additional_vim_regex_highlighting = false,
			},
		}
	end,

}
