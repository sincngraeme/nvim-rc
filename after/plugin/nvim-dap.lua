local dap = require("dap")
-- vim.keymap.set("n", "<down>", function() dap.step_over() end, { desc = "Steps debugger over the current line"})
vim.keymap.set("n", "<leader>xn", function() dap.step_over() end, { desc = "Steps debugger over the current line"})
-- vim.keymap.set("n", "<right>", function() dap.step_into() end, { desc = "Steps debugger into the current line"})
vim.keymap.set("n", "<leader>xi", function() dap.step_into() end, { desc = "Steps debugger into the current line"})
-- vim.keymap.set("n", "<left>", function() dap.step_out() end, { desc = "Steps debugger out of the current scope"})
vim.keymap.set("n", "<leader>xo", function() dap.step_out() end, { desc = "Steps debugger out of the current scope"})
vim.keymap.set("n", "<leader>xtb", function() dap.toggle_breakpoint() end, { desc = "Toggles a breakpoint on the current line"})
vim.keymap.set("n", "<leader>xsb", function() dap.set_breakpoint() end, { desc = "Sets a breakpoint on the current line"})
vim.keymap.set("n", "<leader>xsc", function()
    dap.set_breakpoint(vim.fn.input("Condition: "))
end, { desc = "Sets a conditional breakpoint on the current line"})
vim.keymap.set("n", "<leader>xlb", function() dap.list_breakpoints() end, { desc = "Lists the current breakpoints"})
vim.keymap.set("n", "<leader>xC", function() dap.continue() end, { desc = "Continues program execution to the next breakpoint"})

vim.fn.sign_define('DapBreakpoint',          {text = 'B', texthl = 'Error',   linehl = 'CursorLine', numhl = ''})
vim.fn.sign_define('DapBreakpointCondition', {text = 'b', texthl = 'Warning', linehl = 'CursorLine', numhl = ''})
vim.fn.sign_define('DapLogPoint',            {text = 'L', texthl = 'Info',    linehl = 'CursorLine', numhl = ''})
vim.fn.sign_define('DapBreakpointRejected',  {text = 'R', texthl = 'Error',   linehl = 'CursorLine', numhl = ''})
vim.fn.sign_define('DapStopped',             {text = '>', texthl = 'Info',    linehl = 'CursorLine', numhl = ''})

local ui = require("dapui")

vim.keymap.set("n", "<leader>xx", function() ui.toggle() end, { desc = "Continues program execution to the next breakpoint"})
vim.keymap.set("n", "<leader>xe", function() ui.eval() end, { desc = "Evaluate the expression under the cursor"})
vim.keymap.set("n", "<leader>xf", function() ui.float_element() end, { desc = "Float an element"})

dap.defaults.fallback.terminal_win_cmd = "belowright new"
