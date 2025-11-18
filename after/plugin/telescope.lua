local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind (with) [G]rep' })
vim.keymap.set('n', '<leader>ft', builtin.grep_string, { desc = '[F]ind [T]his' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = '[F]ind (in) [C]urrent (Buffer)' })
vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = '[F]ind [R]egisters' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })

-- Lsp Commands
vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = '[L]sp [R]eferences' })
vim.keymap.set('n', '<leader>lsw', builtin.lsp_workspace_symbols, { desc = '[L]sp [S]ymbols (in) [W]orkspace' })
vim.keymap.set('n', '<leader>lsd', builtin.lsp_document_symbols, { desc = '[L]sp [S]ymbols (in) [D]ocument' })
vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { desc = '[L]sp [I]mplementations' })
vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = '[L]sp [D]efinitions' })
vim.keymap.set('n', '<leader>lt', builtin.lsp_type_definitions, { desc = '[L]sp [T]ype (definitions)' })

-- Git Commands
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = '[G]it [C]ommits' })
vim.keymap.set('n', '<leader>gC', builtin.git_bcommits, { desc = '[G]it (Buffer) [C]ommits' })
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = '[G]it [B]ranches' })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = '[G]it [S]atus' })
