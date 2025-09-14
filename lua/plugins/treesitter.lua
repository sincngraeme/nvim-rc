return {
	"nvim-treesitter/nvim-treesitter",
    dependencies = { "OXY2DEV/markview.nvim" },
	build = ":TSUpdate",
		--local treesitter_install = require 'nvim-treesitter.install'
		--treesitter_install.compilers = { "clang", "gcc" }
		--treesitter_install.prefer_git = false
	--end,
    lazy = false,
	config = function()
		local ts_install = require("nvim-treesitter.install")

		-- Set the compiler for Windows compatibility
		ts_install.compilers = {"clang", "cl", "gcc"}  -- Prioritize "clang" or "gcc" before MSVC's "cl"
		ts_install.prefer_git = false

		require'nvim-treesitter.configs'.setup {
			-- A list of parser names, or "all" (the listed parsers MUST always be installed)
			ensure_installed = { "c", "cpp", "javascript", "python", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "matlab"},

            -- Make sure it is run first
            -- dependencies = {
            --   "OXY2DEV/markview.nvim"  
            -- },
			-- auto_install = false,

			highlight = {
			  enable = true,

			  additional_vim_regex_highlighting = false,
			},
		}
	end,

}
