-- Basic {{{

-- line numbers
vim.opt.nu = true
vim.opt.cursorline = true
vim.opt.rnu = true

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
-- vim.g.termdebug_wide = 1
vim.g.termdebug_config = {
    ["disasm_window"] = 0,
    ["variables_window"] = 0,
    ["sign"] = "<>",
}

-- Persistant undos
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('config') .. '~/.config/nvim/undo'

-- Netrw Appearance
vim.g.netrw_banner = false

-- Disable comment continuation
vim.opt.formatoptions:remove({ 'r', 'o', 'c' })

-- }}}

-- LSP {{{
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.HINT] = '⚑',
      [vim.diagnostic.severity.INFO] = '',
    },
  },
})

vim.opt.completeopt = { "menuone", "noselect", "popup"}
-- }}}

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

