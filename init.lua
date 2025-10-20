-- Load any variables we want persisted (KEEP MINIMAL TO PREVENT SLOWING)

    -- local persist = require('config/persist') -- load the module
    -- vim.g.default_colorscheme = persist.get('default_colorscheme') -- get the default colorscheme
    -- vim.g.bg_transparency = persist.get('bg_transparency') -- get the current transparency setting
    -- -- Now we know which colorscheme to load
    -- vim.cmd("colorscheme " .. vim.g.default_colorscheme)

-- First we load the plugins 
require("sincngraeme.modules.simplug").load_list({
    { name = "plenary", nosetup = true },
    "telescope",
    "nvim-notify",
    "persistence",
})

-- Set the colorscheme
vim.cmd.colorscheme("habamax")

-- Then we load the user settings and remaps
require("sincngraeme.remaps")
require("sincngraeme.settings")

-- Then we load the user modules

-- Then we load the plugin specific "after" settings (plugin specific remaps)

print("Hello There!")
