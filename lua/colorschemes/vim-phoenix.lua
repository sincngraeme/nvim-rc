return {
    link = "widatama/vim-phoenix",
    config = function()
        vim.g.phoenix_acc = "green" -- Default to green
        vim.g.phoenix_invert_match_paren = 1 -- Invert matching parenthesis
    end
}
