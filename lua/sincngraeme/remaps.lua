vim.g.mapleader = " "

-- Open netrw
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)
vim.keymap.set("n", "<leader>lex", vim.cmd.Lex)

-- Open quickfix

-- Reset Directory to Current File
vim.keymap.set({'n','c'}, '<leader>cd', '<cmd>cd %:p:h<cr>')

-- move shit
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Remap system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>y$", "\"+y$")
vim.keymap.set("n", "<leader>yy", "\"+yy")
vim.keymap.set({"n", "v"}, "<leader>p", "\"+p")
vim.keymap.set({"n", "v"}, "<leader>P", "\"+P")

-- I want things to work properly without needing to press escape
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("i", "<C-Space>", "<Esc>")

-- Changing windows when in terminal emulator
vim.keymap.set("t", "<C-W>", "<C-\\><C-N><C-W>", { desc = "Allows for faster window switching" })
vim.keymap.set("t", "<C-S-W>", "<C-W>", { desc = "Gives another way to send CTRL-W" })
-- Default to insert mode
vim.api.nvim_create_autocmd({ "WinEnter" }, {
    pattern = "term://*",
    callback = function()
            vim.cmd("startinsert")
    end
})

-- Overall better window movement
vim.keymap.set("n", "<A-j>", "<C-w>j", { desc = "Window control with alt" })
vim.keymap.set("n", "<A-k>", "<C-w>k", { desc = "Window control with alt" })
vim.keymap.set("n", "<A-h>", "<C-w>h", { desc = "Window control with alt" })
vim.keymap.set("n", "<A-l>", "<C-w>l", { desc = "Window control with alt" })
-- For Terminal
vim.keymap.set("t", "<A-j>", "<C-\\><C-n><C-w>j", { desc = "Window control with alt" })
vim.keymap.set("t", "<A-k>", "<C-\\><C-n><C-w>k", { desc = "Window control with alt" })
vim.keymap.set("t", "<A-h>", "<C-\\><C-n><C-w>h", { desc = "Window control with alt" })
vim.keymap.set("t", "<A-l>", "<C-\\><C-n><C-w>l", { desc = "Window control with alt" })

-- Open new terminal in split
vim.keymap.set("n", "<leader>ots", function()
    vim.cmd("new")
    vim.cmd("term")
    vim.cmd("startinsert")
end, { desc = "Opens terminal in horizontal split" })
vim.keymap.set("n", "<leader>otv", function()
    vim.cmd("vnew")
    vim.cmd("term")
    vim.cmd("startinsert")
end, { desc = "Opens terminal in vertical split" })
-- Open terminal on bottom of screen
vim.keymap.set("n", "<leader>otj", function()
    vim.cmd("new")
    vim.cmd("wincmd J")
    vim.cmd("res 10")
    vim.cmd("term")
    vim.cmd("startinsert")
end, { desc = "Opens terminal on bottom of screen" })
-- Open terminal on left side of screen
vim.keymap.set("n", "<leader>oth", function()
    vim.cmd("new")
    vim.cmd("wincmd H")
    vim.cmd("term")
    vim.cmd("startinsert")
end, { desc = "Opens terminal in on left side of screen" })
-- Open terminal on top of screen
vim.keymap.set("n", "<leader>otk", function()
    vim.cmd("new")
    vim.cmd("wincmd K")
    vim.cmd("res 10")
    vim.cmd("term")
    vim.cmd("startinsert")
end, { desc = "Opens terminal at top of screen" })
-- Open terminal on left side of screen
vim.keymap.set("n", "<leader>otl", function()
    vim.cmd("new")
    vim.cmd("wincmd L")
    vim.cmd("term")
    vim.cmd("startinsert")
end, { desc = "Opens terminal on left side of screen" })
-- Open terminal in new tab
vim.keymap.set("n", "<leader>ott", function()
    vim.cmd("tabnew")
    vim.cmd("term")
    vim.cmd("startinsert")
end, { desc = "Opens terminal in new tab" })

-- Toggle the quickfix list
vim.keymap.set("n", "<leader>tq", vim.cmd.Toggleqf, { desc = "Toggle the quickfix list" })

-- Autopairing Brackets
vim.keymap.set({"i", "n"}, "{<CR>", "{<CR>}<C-c>ko")
vim.keymap.set({"i", "n"}, "(<CR>", "(<CR>)<C-c>ko<Tab>")
vim.keymap.set({"i", "n"}, "[<CR>", "[<CR>]<C-c>ko<Tab>")
vim.keymap.set({"i", "n"}, "/*<CR>", "/*<CR><CR>*/<C-c>0xxk$a")

-- Toggle lsp semantic tokens
vim.keymap.set("n", "<leader>tst", function()
    vim.lsp.semantic_tokens.enable(
        not vim.lsp.semantic_tokens.is_enabled()
    )
end, { desc = "[T]oggle (LSP)[S]emantic [T]okens"})

-- Save and Quit
vim.keymap.set("n", "<leader>wa", vim.cmd.wa)
vim.keymap.set("n", "<leader>qa", vim.cmd.qa)
vim.keymap.set("n", "<leader>wqa", vim.cmd.wqa)
vim.keymap.set("n", "<leader>ww", vim.cmd.w)
vim.keymap.set("n", "<leader>Q", '<cmd>q!<CR>')
vim.keymap.set("n", "<leader>Qa", '<cmd>qa!<CR>')

-- Open nvimrc
local rc_path = vim.fn.stdpath("config")
vim.keymap.set("n", "<leader>orc", "<cmd>tabnew " .. rc_path .. "<CR>")
-- vim.keymap.set("n", "<leader>q!", vim.cmd.q!)

-- Move a visual selection (not the text just the highlight)
vim.keymap.set("v", "<C-k>", "okok")
vim.keymap.set("v", "<C-j>", "jojo")
vim.keymap.set("v", "<C-h>", "hoho")
vim.keymap.set("v", "<C-l>", "olol")

-- Yank and put cursor on end
vim.keymap.set("v", "Y", "y`>")
vim.keymap.set("v", "D", "d`>")

-- Stay in visual mode after yanking/deleting
vim.keymap.set("v", "<M-y>", "ygv")
vim.keymap.set("v", "<M-d>", "dgv")

-- Side scrolling
vim.keymap.set( "n", "<C-l>", "zL", { desc = "Scrolls the view sideways left"})
vim.keymap.set( "n", "<C-h>", "zH", { desc = "Scrolls the view sideways right"})

-- Toggling Relative Line Numbers
vim.keymap.set( "n", "<leader>tr", vim.cmd.ToggleRNU)

-- Trim Trailing Whitespace in File
vim.keymap.set("n", "<leader>tw", "<cmd>%s/\\s*$//g<CR>''")
vim.keymap.set("v", "<leader>tw", "<cmd>'<,'>s/\\s*$//g<CR>")
