local export_path = nil
if vim.g.is_win then
    export_path = vim.fn.expand("$HOME") .. "\\Documents\\PDFs\\%:t:r.pdf"
else
    export_path = vim.fn.expand("$HOME") .. "/Documents/PDFs/%:t:r.pdf"
end
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
if export_path then
    local choose_engine = function(args)
        if args and args == "typst" then
            vim.opt_local.makeprg = "pandoc  '%' --pdf-engine=typst  " ..
                "--from=markdown+wikilinks_title_after_pipe " ..
                "-t pdf " ..
                "--template='report.typ'  " ..
                "-o '" .. export_path .. "'"
        elseif args == "weasyprint" then
            vim.opt_local.makeprg = "pandoc  '%' --pdf-engine=weasyprint " ..
                "-f markdown " ..
                "-t pdf " ..
                -- "--template='report.html'  " ..
                "-o '" .. export_path .. "'"
        elseif args == "latex" then
            vim.opt_local.makeprg = "pandoc  '%' --pdf-engine=xelatex " ..
                "-f markdown " ..
                "-t pdf " ..
                -- "--template='report.latex'  " ..
                "-o '" .. export_path .. "'"
        end
    end
    choose_engine("latex")
    vim.api.nvim_create_user_command("MarkdownEngine", function(opts)
        print("PDF Render Engine: " .. vim.inspect(opts.args))
        choose_engine(opts.args)
    end, { nargs = 1 })
end

-- Toggling checkboxes

-- Complete 'x'
vim.keymap.set("n", "<leader>tcx", function()
    vim.cmd([[.g/^\s*- \[.\]/s/\(^\s*- \[\).\]/\1x]/]])
end, { desc = "[T]oggle (markdown) [C]heckbox (with) [x]"})
-- Incomplete' '
vim.keymap.set("n", "<leader>tc ", function()
    vim.cmd([[.g/^\s*- \[.\]/s/\(^\s*- \[\).\]/\1 ]/]])
end, { desc = "[T]oggle (markdown) [C]heckbox (with) [ ]"})
-- In progress '/'
vim.keymap.set("n", "<leader>tc/", function()
    vim.cmd([[.g/^\s*- \[.\]/s/\(^\s*- \[\).\]/\1\/]/]])
end, { desc = "[T]oggle (markdown) [C]heckbox (with) [/]"})
-- Important '!'
vim.keymap.set("n", "<leader>tc!", function()
    vim.cmd([[.g/^\s*- \[.\]/s/\(^\s*- \[\).\]/\1\!]/]])
end, { desc = "[T]oggle (markdown) [C]heckbox (with) [!]"})
-- Postponed 'b'
vim.keymap.set("n", "<leader>tcb", function()
    vim.cmd([[.g/^\s*- \[.\]/s/\(^\s*- \[\).\]/\1b]/]])
end, { desc = "[T]oggle (markdown) [C]heckbox (with) [b]"})
