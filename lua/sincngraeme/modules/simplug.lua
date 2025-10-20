local M = {}

local default_plugin_dir = "plugins"
local remote_url = "https://github.com/"
local pack_list = {}  -- absolute links for instalations
local config_list = {} -- Configurations for each plugin
local log_level = vim.log.levels.INFO

function M.load(plugin_list, plugin_dir) plugin_dir = plugin_dir or default_plugin_dir
    for i, plugin in ipairs(plugin_list) do
        -- Git link handling
        local module = require(plugin_dir .. "." .. plugin)
        if type(module.link) == "string" then -- Sometimes a branch is specified (pass a table instead)
            table.insert(pack_list, remote_url .. module.link)
        else
            table.insert(pack_list, { src = remote_url .. module.link.src, version = module.link.version })
        end
        table.insert(config_list, module.config)
    end
    -- Install
    vim.pack.add(pack_list)
    -- Configure
    for i, plugin_config in ipairs(config_list) do
        if not plugin_config then -- Do nothing
            -- vim.notify(plugin_list[i] .. ": No Config", log_level)
        else
            if type(plugin_config) == "table" then
                vim.notify("Error loading config for: " .. plugin_list[i] .. "Config must be a function", 
                    vim.log.levels.ERROR)
            else 
                -- vim.notify(plugin_list[i] .. ": Config Loaded Successfully", log_level)
                plugin_config()
            end
        end
    end
end

return M
