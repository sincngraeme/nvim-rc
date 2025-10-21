-- Toggle markdown preview
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
      vim.keymap.set("n", "<leader>mm", vim.cmd.Markview) 
  end
})
