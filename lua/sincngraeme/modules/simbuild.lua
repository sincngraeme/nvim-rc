local M = {}

local config = {
    command_name = "Make"
}

---@param user_config {
    ---
    ---}
function M.setup(user_config)
    if user_config then
        if user_config.command_name then config.command_name = user_config.command_name end
    end
end

local define = function()
    vim.api.nvim_create_autocmd("TermClose", {
        -- pattern = { "Simbuild" },
        callback = function()
            -- print(table.concat(vim.api.nvim_buf_get_lines(0, 0, -2, true), "\n"))
            -- vim.cmd("cgetexpr " .. table.concat(vim.api.nvim_buf_get_lines(0, 0, -2, true), "\n"))
            vim.cmd('cgetexpr getline(1, "$")')
        end
    })
    vim.api.nvim_create_user_command(config.command_name, function(opts)
        vim.cmd("new")
        vim.cmd("wincmd J")
        vim.cmd("res 10")
        -- vim.api.nvim_buf_set_name(0, "Simbuild")
        vim.cmd("term " .. "make " .. table.concat(opts.fargs, " "))
        -- print(table.concat(vim.api.nvim_buf_get_lines(bufno, 0, -2, true), "\n"))
        vim.cmd("startinsert")
        -- vim.cmd("cgetexpr " .. table.concat(vim.api.nvim_buf_get_lines(0, 0, -2, true), "\n"))
    end, { bang = true, nargs = "*" })
end

define()
-- vim.keymap.set( "n", "<>"define())

return M
