return {
    link = "nvim-treesitter/nvim-treesitter",
    config = function()
	    if vim.fn.executable('tree-sitter') == 0 then
            vim.notify(
                "Treesitter CLI Not installed: " .. 
                "https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md"
            ) 
            return
        end
        -- Enabling Highlights
        vim.api.nvim_create_autocmd('FileType', { 
            callback = function() 
                -- Enable treesitter highlighting and disable regex syntax
                pcall(vim.treesitter.start) 
                -- Enable treesitter-based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" 
            end, 
        }) 
	    -- If we do have the treesitter CLI
        local ts = require("nvim-treesitter")

        ts.install({
            "c", "cpp",
            "javascript", "html", "css",
            "python",
            "lua",
            "vim", "vimdoc",
            "query",
            "markdown", "markdown_inline", "yaml",
            "typst"
        })
    end
}
