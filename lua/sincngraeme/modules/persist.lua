local vim = vim
local json = vim.fn.json_decode

local M = {}

-- The name of the file
local data_file = vim.fn.stdpath("config") .. "/persist.json"
M.data = {}

-- Load the Persisted data from the file {{{
function M.load()
    local f = io.open(data_file, "r") -- Open
    if f then 
        local content = f:read("*a") -- Read full file
        f:close()
        if content and #content > 0 then -- check for nil or false and length <= 0
            local ok, decoded = pcall(vim.fn.json_decode, content)
            if ok and type(decoded) == "table" then -- success and correct type
                M.data = decoded -- store
            end
        end
    end
end -- }}}

-- Save the current data to the file {{{
function M.save()
    local f = io.open(data_file, "w") -- open
    if not f then
        vim.notify("Failed to save persistance file: " .. data_file, vim.log.levels.ERROR)
        return
    end
    local content = vim.fn.json_encode(M.data) -- Encode the data
    f:write(content)
    f:close()
end
-- }}}

-- Set a value by key and save {{{
function M.set(key, value)
    M.data[key] = value
    M.save()
end
-- }}}

-- Get a value by key {{{
function M.get(key)
    return M.data[key]
end
-- }}}

-- Load immediatly on require
M.load()

return M
