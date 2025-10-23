vim.g.mapleader = " "

-- Open netrw
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)
vim.keymap.set("n", "<leader>lex", vim.cmd.Lex)

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
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+P")

-- I want things to work properly without needing to press escape
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("i", "<C-Space>", "<Esc>")

-- Exiting terminal emulator
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]])

-- Autopairing Brackets
vim.keymap.set({"i", "n"}, "{<CR>", "{<CR>}<C-c>ko")
vim.keymap.set({"i", "n"}, "(<CR>", "(<CR>)<C-c>ko<Tab>")
vim.keymap.set({"i", "n"}, "[<CR>", "[<CR>]<C-c>ko<Tab>")
vim.keymap.set({"i", "n"}, "/*<CR>", "/*<CR><CR>*/<C-c>0xxk$a")

-- Buffer Switching
vim.keymap.set("n", "<leader>bn", vim.cmd.bn)
vim.keymap.set("n", "<leader>bp", vim.cmd.bp)

-- Save and Quit
vim.keymap.set("n", "<leader>wa", vim.cmd.wa)
vim.keymap.set("n", "<leader>qa", vim.cmd.qa)
vim.keymap.set("n", "<leader>wqa", vim.cmd.wqa)
vim.keymap.set("n", "<leader>ww", vim.cmd.w)
vim.keymap.set("n", "<leader>q!", '<cmd>q!<CR>')
vim.keymap.set("n", "<leader>qa!", '<cmd>qa!<CR>')
vim.keymap.set("n", "<leader><leader>", vim.cmd.bn)

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
vim.keymap.set( "n", "<C-l>", "zL")
vim.keymap.set( "n", "<C-h>", "zH")

-- Toggling Relative Line Numbers
vim.keymap.set( "n", "<leader>tr", vim.cmd.ToggleRNU)

-- Search in file for item under cursor (no lsp or telescope)
-- This only works in insert mode to add some speed
-- For similar functionality in
vim.keymap.set("i", "<C-/>", "<Esc>/<C-r><C-w>", { desc = "Foreward searches current buffer for word under cursor (insert mode)" })
vim.keymap.set("i", "<CS-/>", "<Esc>?<C-r><C-w>", { desc = "Reverse searches current buffer for word under cursor (insert mode)" })

-- Trim Trailing Whitespace in File
vim.keymap.set("n", "<leader>tw", "<cmd>%s/\\s*$//g<CR>")
vim.keymap.set("v", "<leader>tw", "<cmd>'<,'>s/\\s*$//g<CR>")
