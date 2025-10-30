-- Toggle markdown preview
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
      vim.keymap.set("n", "<leader>mm", vim.cmd.Markview)
      vim.opt.wrap = true
      vim.opt.wrapmargin = 5
      vim.opt.linebreak = true
      vim.opt.spell = true
      vim.opt.spelllang = {'en_us', 'en_gb'}
      vim.opt.makeprg = [[pandoc  "%" --pdf-engine=typst  --template="report.typ"  -o "%:r.pdf" && mupdf "%:r.pdf"]]
  end
})
