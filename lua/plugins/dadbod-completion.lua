return {
    link = "kristijanhusak/vim-dadbod-completion",
    config = function()
        vim.filetype.add({
            extension = {
                sql = "sql",
                mysql = "mysql",
            },
        })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "sql", "mysql", "plsql" },
            callback = function()
                vim.bo.omnifunc = "vim_dadbod_completion#omni"
            end,
        })
    end
}
