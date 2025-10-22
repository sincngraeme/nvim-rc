local M = {}

-- LSP Remaps
vim.opt.signcolumn = 'yes'
-- Enabling features only when there is an active LSP in the buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set('n', '<leader>k', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '>d', function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set('n', '<d', function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', '<leader>vff', function() vim.lsp.buf.format({async = true}) end, opts)
    vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
  end,
})

-- Configure LSP Clients

-- Default (Will be used for all unless specified otherwise)
vim.lsp.config('*', {
    root_markers = { '.git' },
})

M.lsp_list = {}

function M.get_lsp_config(lsp, script)
    script = script or false
    local dir = vim.fn.stdpath("config") .. "/lua/lsp"
    local path = dir .. "/" .. lsp .. ".lua"
    local url = "https://raw.githubusercontent.com/neovim/nvim-lspconfig/refs/heads/master/lsp/"
    local url_complete = url .. lsp .. ".lua"

    -- set the directory
    -- vim.fn.chdir(dir)
    -- Download the file
    -- Example: curl --silent -w "%{http_code}" https://raw.githubusercontent.com/neovim/nvim-lspconfig/refs/heads/master/lsp/lua_ls.lua -o lua_ls.lua
    vim.notify("Downloading lsp config for " .. lsp .." from: " .. url, vim.log.levels.INFO)
    local result = vim.system({
        "curl",
        "-sw",
        "%{http_code}",
        url_complete,
        "-o",
        path
    }, { cwd = dir }):wait()
    print(vim.inspect(result))
    if result.stdout ~= "200" then
        vim.notify("Lsp Config Failed to Download", vim.log.levels.ERROR)
        if vim.fn.filereadable(path) then
            vim.fn.delete(path)
        end
    else
        vim.notify("Lsp Config Successfully Downloaded", vim.log.levels.INFO)
        -- if vim.fn.filereadable(path) then
        -- Open the file for review in new tab
        if not script then vim.cmd.tabnew(path) end
    end
    -- vim.fn.chdir(pwd)
end

-- Function to download an individual config file from https://github.com/neovim/nvim-lspconfig
vim.api.nvim_create_user_command('LspGetConfig', function(opts)
    M.get_lsp_config(opts.args)
end, { nargs = 1, complete = function() return M.lsp_list end }) -- This uses our lsp list to source the completion

-- Function to iterate over the table and initialize all the LSPs
function M.init()
    local lsp_dir = "lsp"
    local user_input = "y"
    for _, lsp in ipairs(M.lsp_list) do
        local lsp_path = lsp_dir .. "." .. lsp
        local ok, module = pcall(require, lsp_path) -- If the module does not exist don't load
        if ok then
            vim.lsp.config(lsp, module)
            vim.lsp.enable(lsp)
        else
            if not user_input:match("^[YN]") then
                vim.notify("LSP config file for " .. lsp .. " not found.", vim.log.levels.WARNING)
                user_input = vim.fn.input("Download " .. lsp .."? ([y]es|[n]o|[Y]es to all|[N]o to all):")
                user_input = user_input:match("^[yYnN]")
            end
            -- Download if yes or Yes
            if user_input:match("^[yY]") then M.get_lsp_config(lsp, true) end
        end
    end
end

return M
