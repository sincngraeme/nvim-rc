local M = {}

local plugin_dir_relative = "plugins"
local remote_url = "https://github.com/"

function M.load_list(plugin_list)
    local pack_list = {}  -- relative links for installing with builtin plugin manager
    local setup_list = {} -- 
    local nosetup = {}    -- the list of plugins to not run setup for
    for i, plugin in ipairs(plugin_list) do
	-- Handling table inputs
        if type(plugin) == "table" then -- We may specify no setup
            table.insert(nosetup, plugin.nosetup)
            plugin = plugin.name
            plugin_list[i] = plugin
        else
	    table.insert(nosetup, false)
        end
	-- Git link handling
        local config = require(plugin_dir_relative .. "." .. plugin)
        if type(config.link) == "string" then -- Sometimes a branch is specified (pass a table instead)
            table.insert(pack_list, remote_url .. config.link)
        else
            table.insert(pack_list, { src = remote_url .. config.link.src, version = config.link.version })
        end
        table.insert(setup_list, config.setup)
    end
    -- Install
    vim.pack.add(pack_list)
    -- Configure
    for i, plugin_setup in ipairs(setup_list) do
        if nosetup[i] then -- Do nothing
            print("Setup module ignored: " .. plugin_list[i])
        else
            local ok, module = pcall(require, plugin_list[i])
            if ok and type(module.setup) == "function" then
		if type(plugin_setup) == "function" then module.setup(plugin_setup()) 
		elseif type(plugin_setup) == "table" then module.setup(plugin_setup) end
                print(plugin_list[i] .. " Loaded successfully")
            else
                vim.notify("Failed to load " .. type(module.setup) .. 
                " " .. vim.inspect(module.setup) .. "for plugin" .. 
                plugin_list[i], vim.log.levels.ERROR)
            end
        end
    end
end

return M
