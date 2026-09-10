-- enable the better UI
-- (require('vim._core.ui2')).enable({})

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
if vim.g.is_win then
    if vim.fn.executable("pwsh") == 1 then
        vim.o.shell = "pwsh"
        vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command "
        vim.o.shellredir   = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
        vim.o.shellpipe    = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
        vim.o.shellquote   = ""
        vim.o.shellxquote  = ""
    elseif vim.fn.executable("powershell") == 1 then
        vim.o.shell = "powershell"
        vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command "
        vim.o.shellredir   = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
        vim.o.shellpipe    = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
        vim.o.shellquote   = ""
        vim.o.shellxquote  = ""
    else
        vim.o.shell = "cmd"
    end
else
    vim.o.shell = "bash"
end

vim.g.termdebug_wide = 1
vim.g.termdebug_config = {
    ["disasm_window"] = 0,
    ["variables_window"] = 0,
    ["sign"] = "B",
}

-- Persistant undos
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('config') .. '/undo/'

-- Netrw Appearance
vim.g.netrw_banner = false

-- Disable comment continuation
vim.opt.formatoptions:remove({ 'r', 'o', 'c' })

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

