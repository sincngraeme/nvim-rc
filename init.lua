-- Load any variables we want persisted (KEEP MINIMAL TO PREVENT SLOWING)

local instinct = require('sincngraeme.modules.instinct')
vim.g.default_colorscheme = instinct.get('default_colorscheme')
vim.g.bg_transparency = instinct.get('bg_transparency')

-- Load the package manager
local simplug = require("sincngraeme.modules.simplug")
-- Configure
simplug.setup({
    always_update = false,
})

-- Load the colorschemes 
simplug.load({
    "kanagawa",
    "tokyonight",
}, "colorschemes")

-- Now we know which colorscheme to load
vim.cmd.colorscheme(vim.g.default_colorscheme)

-- Load the plugins (order matters)
simplug.load({
    "nvim-notify",
    "treesitter",
    "plenary",
    "telescope",
    "persistence",
    "markview",
    "undotree",
    "vim-scimark",
    "vim-surround",
    "flash-nvim",
    "obsidian",
    "image-preview",
    "telescope-media-files",
    "live-preview",
    -- "markdown-preview",
    "marp",
})

-- Clean the unused plugins
simplug.clean()

-- Load the user settings and remaps
require("sincngraeme.remaps")
require("sincngraeme.settings")
require("sincngraeme.cmds")

--- LSP SETUP ---

local lsp_config = require("lsp.default")

-- List of LSPs we want setup 
-- Configs pulled from https://github.com/neovim/nvim-lspconfig/tree/master/lsp
-- TODO: Update init() to accept table as arg rather than separate variable
lsp_config.lsp_list = {
    "clangd", -- c
    "lua_ls", -- lua
    -- { name = "bashls", executable = "bash-language-server" }
}

-- initialize them all
lsp_config.init()
