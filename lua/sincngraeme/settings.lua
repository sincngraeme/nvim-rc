-- Basic {{{

-- line numbers
vim.opt.nu = true
vim.opt.cursorline = true

-- Fix the god-awful indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- no line wrap
vim.opt.wrap = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Folds
vim.o.foldenable = true
vim.o.foldmethod = 'marker'

-- Default terminal
vim.o.shell = "bash"

-- Persistant undos
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('config') .. '~/.config/nvim/undo'
-- }}}

-- Diagnostic Symbols {{{
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.HINT] = '⚑',
      [vim.diagnostic.severity.INFO] = '',
    },
  },
}) -- }}}

-- Tab Symbols for Makefile {{{
vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function()
    vim.bo.expandtab = false   -- use actual tabs
    vim.bo.shiftwidth = 4      -- how much a tab 'feels' like
    vim.bo.tabstop = 4         -- actual width of a tab
    vim.bo.softtabstop = 4     -- for insert-mode tab behavior
    vim.opt.list = true
    vim.opt.listchars:append("tab:→ ")
  end
}) -- }}}

-- Function to set the default colorscheme {{{
function _G.set_colorscheme(name)
    local persist = require('config/persist')
    local ok, _ = pcall(vim.cmd, "colorscheme " .. name) -- Protected call to set it
    if ok then -- Success
        persist.set("default_colorscheme", name) -- Persist var
        vim.g.default_colorscheme = name -- Set var
        vim.notify("Default colorscheme set to " .. name)
    else
        -- Don't set
        vim.notify("Colorscheme '" .. name .. "' not found!", vim.log.levels.ERROR)
    end
end

-- Define command to call the function
vim.api.nvim_create_user_command("ColorSetDefault", function(opts)
    _G.set_colorscheme(opts.args)
end, { nargs = 1, complete = "color"}) -- Requires an argument, enables completion
-- }}}

-- Function for toggling the bg transparency {{{
function _G.toggle_bg_transparency()
    local persist = require('config/persist')
    local transparency = vim.g.bg_transparency -- For Speed

    -- Toggle value
    if type(transparency) == 'boolean' then
        transparency = not transparency
    elseif transparency then -- Check if nil
        vim.notify("Transparency must be boolean but it is '" .. type(transparency) .. "'!", vim.log.levels.ERROR)
        return
    else
        transparency = false -- default to false
        vim.notify("Transparency was nil, defaulted to false" , vim.log.levels.WARNING)
    end

    vim.g.bg_transparency = transparency -- set the transparancy variable
    persist.set("bg_transparency", transparency) -- set the persistance
    vim.notify("Transparency set to " .. tostring(transparency) , vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("ToggleTransparency", function()
    _G.toggle_bg_transparency()
end, {}) -- }}}

-- Hot reload RC {{{
function _G.ReloadConfig()
  for name,_ in pairs(package.loaded) do
    if name:match('^sincngraeme') and not name:match('nvim-tree') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end -- }}}

-- Hot Reload Plugins {{{
function _G.ReloadPlugins()
  for name,_ in pairs(package.loaded) do
    if name:match('^plugins') and not name:match('nvim-tree') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim plugins reloaded!", vim.log.levels.INFO)
end -- }}}

-- LSP Setup {{{
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
-- }}}

-- Toggling Relative Line numbers {{{
function _G.toggle_relative_ln()
    local rn = vim.o.rnu
    vim.o.rnu = not rn
end

vim.api.nvim_create_user_command('ToggleRNU', function()
	_G.toggle_relative_ln()
end, {})
-- }}}
