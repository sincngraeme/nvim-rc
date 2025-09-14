-- Load any variables we want persisted (KEEP MINIMAL TO PREVENT SLOWING)

    local persist = require('config/persist') -- load the module
    vim.g.default_colorscheme = persist.get('default_colorscheme') -- get the default colorscheme
    vim.g.bg_transparency = persist.get('bg_transparency') -- get the current transparency setting
    -- Now we know which colorscheme to load
    vim.cmd("colorscheme " .. vim.g.default_colorscheme)

require("config.lazy")
require("sincngraeme.remaps")
require("sincngraeme.settings")
print("Hello There!")
