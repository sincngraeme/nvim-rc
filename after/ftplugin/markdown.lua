vim.opt_local.conceallevel = 2
local export_path = "/home/sincngraeme/Documents/PDFs/%:t:r.pdf"
vim.keymap.set("n", "<leader>mm", vim.cmd.Markview)
vim.opt.wrap = true
vim.opt.wrapmargin = 5
vim.opt.linebreak = true
vim.opt.spell = true
vim.opt.spelllang = {'en_us', 'en_gb'}
local bufnr = vim.api.nvim_get_current_buf()
local choose_engine = function(args)
    if args and args == "typst" then
        vim.bo[bufnr].makeprg = "pandoc  '%' --pdf-engine=typst  " ..
            "--from=markdown+wikilinks_title_after_pipe " ..
            "-t pdf " ..
            "--template='report.typ'  " ..
            "-o '" .. export_path .. "' && " ..
            "mupdf '" .. export_path .. "'"
    elseif args == "weasyprint" then
        vim.bo[bufnr].makeprg = "pandoc  '%' --pdf-engine=weasyprint " ..
            "-f markdown " ..
            "-t pdf " ..
            -- "--template='report.html'  " ..
            "-o '" .. export_path .. "' && " ..
            "mupdf '" .. export_path .. "'"
    elseif args == "latex" then
        vim.bo[bufnr].makeprg = "pandoc  '%' --pdf-engine=pdflatex " ..
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
