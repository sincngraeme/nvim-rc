-- Load any variables we want persisted (KEEP MINIMAL TO PREVENT SLOWING)

local persist = require('sincngraeme.modules.instinct')
vim.g.default_colorscheme = persist.get('default_colorscheme')
vim.g.bg_transparency = persist.get('bg_transparency')

-- Load the colorschemes 
require("sincngraeme.modules.simplug").load({
    "kanagawa",
    "tokyonight",
}, "colorschemes")

-- Now we know which colorscheme to load
vim.cmd.colorscheme(vim.g.default_colorscheme)

-- Load the plugins (order matters)
require("sincngraeme.modules.simplug").load({
    "nvim-notify",
    "treesitter",
    "plenary",
    "telescope",
    "persistence",
    "markview",
    "undotree",
})

-- Load the user settings and remaps
require("sincngraeme.remaps")
require("sincngraeme.settings")
require("sincngraeme.cmds")

--- LSP SETUP ---

local lsp_config = require("lsp.default")

-- List of LSPs we want setup 
lsp_config.lsp_list = {
    "clangd", -- c
    "lua_ls", -- lua
    { name = "bashls", executable = "bash-language-server" }
}

-- initialize them all
lsp_config.init()
