notify = require("notify")
vim.keymap.set('n', '<leader>on', notify.open, 
    { desc = '[O]pen [N]otifications'})
