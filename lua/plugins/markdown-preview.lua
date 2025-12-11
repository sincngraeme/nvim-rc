return {
    link = "iamcco/markdown-preview.nvim",
    config = function()
        vim.fn["mkdp#util#install"]()
    end
}
