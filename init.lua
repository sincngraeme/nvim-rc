-- Load any variables we want persisted (KEEP MINIMAL TO PREVENT SLOWING)

local instinct = require('sincngraeme.modules.instinct')
vim.g.default_colorscheme = instinct.get('default_colorscheme')
vim.g.bg_transparency = instinct.get('bg_transparency')

-- Load the package manager
vim.pack.add({ "https://github.com/sincngraeme/simplug.nvim" })
-- local simplug = require("sincngraeme.modules.simplug")
local simplug = require("simplug")
-- Configure
simplug.setup({
    always_update = false,
    offline_load = true
})

-- Load the color schemes 
simplug.load({
    "kanagawa",
    "tokyonight",
}, "colorschemes")

-- Now we know which color scheme to load
vim.cmd.colorscheme("habamax")

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
    "nvim-treesitter-textobjects",
    -- "obsidian",
    "image-preview",
    -- "telescope-media-files",
    -- "live-preview",
    -- "markdown-preview",
    "nvim-dap",
    "nvim-nio",
    "nvim-dap-ui",
})

-- Loading builtins (And already downloaded plugins)
vim.cmd("packadd! termdebug")

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
}

-- initialize them all
lsp_config.init()
