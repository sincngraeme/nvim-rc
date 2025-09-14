vim.g.mapleader = " "

-- Open netrw
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)

-- Open UndoTree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

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

-- Exiting terminal emulator
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

-- For toggling ctags window
vim.keymap.set("n", "<leader>tt",vim.cmd.TagbarToggle)

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

-- Open nvimrc
-- vim.keymap.set("n", "<leader>orc", [[:tabnew $MYVIMRC/..<CR]])

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
