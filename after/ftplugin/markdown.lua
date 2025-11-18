local export_path = "/home/sincngraeme/Documents/PDFs/%:t:r.pdf"

-- Filetype specific keymaps
vim.keymap.set("n", "<leader>mm", vim.cmd.Markview, { desc = "Toggles markdown preview", buffer = true })
vim.keymap.set("n", "<leader>z=", "1z=", { desc = "Accept first spell suggestion", buffer = true })
vim.keymap.set("n", "<leader>zl", "z=", { desc = "List spelling suggestions", buffer = true })
-- Filetype specific options
vim.opt_local.conceallevel = 2
vim.opt_local.wrap = true
vim.opt_local.wrapmargin = 5
vim.opt_local.linebreak = true
vim.opt_local.spell = true
vim.opt_local.spelllang = {'en_us', 'en_gb'}
-- Filetype specific commands
local choose_engine = function(args)
    if args and args == "typst" then
        vim.opt_local.makeprg = "pandoc  '%' --pdf-engine=typst  " ..
            "--from=markdown+wikilinks_title_after_pipe " ..
            "-t pdf " ..
            "--template='report.typ'  " ..
            "-o '" .. export_path .. "' && " ..
            "mupdf '" .. export_path .. "'"
    elseif args == "weasyprint" then
        vim.opt_local.makeprg = "pandoc  '%' --pdf-engine=weasyprint " ..
            "-f markdown " ..
            "-t pdf " ..
            -- "--template='report.html'  " ..
            "-o '" .. export_path .. "' && " ..
            "mupdf '" .. export_path .. "'"
    elseif args == "latex" then
        vim.opt_local.makeprg = "pandoc  '%' --pdf-engine=pdflatex " ..
            "-f markdown " ..
            "-t pdf " ..
            "--template='report.latex'  " ..
            "-o '" .. export_path .. "' && " ..
            "mupdf '" .. export_path .. "'"
    end
end
choose_engine("typst")
vim.api.nvim_create_user_command("MarkdownEngine", function(opts)
    print("PDF Render Engine: " .. vim.inspect(opts.args))
    choose_engine(opts.args)
end, { nargs = 1 })
