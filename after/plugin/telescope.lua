-- Telescope bindings, and custom pickers

local ok, telescope = pcall(require, 'telescope')
if not ok then
    vim.notify("Failed to load module: Telescope", vim.log.levels.ERROR)
    return
end
local builtin = require("telescope.builtin")

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind (with) [G]rep' })
vim.keymap.set('n', '<leader>ft', builtin.grep_string, { desc = '[F]ind [T]his' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = '[F]ind (in) [C]urrent (Buffer)' })
vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = '[F]ind [R]egisters' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
vim.keymap.set('n', '<leader>fm', builtin.man_pages, { desc = '[F]ind [M]anpages' })

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

-- Custom Functions
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
-- Plenary for file system traversal
local scan = require('plenary.scandir')

local function choose_dir(query_root, opts) 
    query_root = query_root or "$HOME"
    query_root = vim.fn.expand(query_root) 
    opts = opts or {}

    print("Loading dirs...")
    pickers.new(opts, {
        prompt_title = "Directory Search: " .. query_root,
        finder = finders.new_table({
            results = scan.scan_dir(query_root, {
                respect_gitignore = false,
                hidden = true,
                only_dirs = true, 
                search_pattern = function(entry)
                    return not entry:match("^.*%.git.*$")
                end,
            })
        }),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                selection = action_state.get_selected_entry()
                vim.notify("Selected: " .. vim.inspect(selection[1]), vim.log.levels.INFO)
                vim.cmd("cd " .. selection[1])
            end)
            return true
        end
    }):find()
end

local function get_filetype()
  return vim.bo.filetype or ""
end

local path_separator = '/'
if vim.g.is_win then
    path_separator = '\\'
end

-- Custom
vim.keymap.set('n', '<leader>fdh', function() choose_dir("$HOME") end, { desc = '[F]ind [D]irectories (in) [H]ome (folder)' })
vim.keymap.set('n', '<leader>fdc', function() choose_dir(".") end, { desc = '[F]ind [D]irectories (in) [C]urrent (folder)' })
vim.keymap.set('n', '<leader>fdr', function() choose_dir("/") end, { desc = '[F]ind [D]irectories (in) [R]oot (folder)' })
vim.keymap.set('n', '<leader>fdp', function() choose_dir("$HOME" .. path_separator .. "Projects") end, { desc = '[F]ind [D]irectories (in) [R]oot (folder)' })
if vim.g.is_win then
    vim.keymap.set('n', '<leader>fdd', function() choose_dir("$HOME\\appdata\\local\\nvim") end, { desc = '[F]ind [D]irectories (in) [D]otfiles (folder)' })
else
    vim.keymap.set('n', '<leader>fdd', function() choose_dir("$HOME/.config") end, { desc = '[F]ind [D]irectories (in) [D]otfiles (folder)' })
end
