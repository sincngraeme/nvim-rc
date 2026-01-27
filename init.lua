-- Load any variables we want persisted (KEEP MINIMAL TO PREVENT SLOWING)

local instinct = require('sincngraeme.modules.instinct')
vim.g.default_colorscheme = instinct.get('default_colorscheme')
vim.g.bg_transparency = instinct.get('bg_transparency')

vim.g.is_win = vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
vim.g.is_mac = vim.fn.has('macunix') == 1    -- works on macOS & BSD
vim.g.is_unix = vim.fn.has('unix') == 1

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
    "smoke-nvim",
    "vim-phoenix",
    "everforest"
}, "colorschemes")

-- Now we know which color scheme to load
vim.cmd.colorscheme(vim.g.default_colorscheme)

-- Load the plugins (order matters)
simplug.load({
    -- "nvim-notify",
    "fidget-nvim",
    "treesitter",
    "plenary",
    "telescope",
    "persistence",
    "markview",
    "markdown-preview",
    "undotree",
    "vim-scimark",
    "vim-surround",
    -- "flash-nvim",
    "nvim-treesitter-textobjects",
    -- "image-preview",
    "nvim-dap",
    "nvim-nio",
    "nvim-dap-ui",
    "vim-dispatch",
    -- "obsidian"
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

-- Configs pulled from https://github.com/neovim/nvim-lspconfig/tree/master/lsp
local lsp_config = require("sincngraeme.modules.simplsp").init({
    "clangd-c",     -- C
    "clangd-cpp",   -- C++
    "lua_ls",       -- lua
    "pylsp",        -- python
})
