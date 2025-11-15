return {
    link = "epwalsh/obsidian.nvim",
    config = function()
        require("obsidian").setup({
            workspaces = {
                {
                    name = "SecondBrain",
                    path = "~/Documents/SecondBrain",
                }
            },
            ui = {
                enable = false,
            },
            picker = {
                name = "telescope.nvim",
            },
            attachments = {
                img_folder = "./attachments"
            },
            wiki_link_func = function(opts)
                -- opts contains: path, label, id
                -- Calculate relative path from current file to target
                local current_file = vim.api.nvim_buf_get_name(0)
                local current_dir = vim.fn.fnamemodify(current_file, ":h")
                local relative_path = vim.fn.fnamemodify(opts.path, ":~:.")

                -- Make path relative to current file's directory
                local Path = require("obsidian.path")
                local target = Path.new(opts.path)
                local from = Path.new(current_dir)
                local rel = target:relative_to(from)

                if opts.label ~= opts.path then
                    return string.format("[[%s|%s]]", rel, opts.label)
                else
                    return string.format("[[%s]]", rel)
                end
            end,

            markdown_link_func = function(opts)
                -- Similar logic for markdown-style links
                local current_file = vim.api.nvim_buf_get_name(0)
                local current_dir = vim.fn.fnamemodify(current_file, ":h")
                local Path = require("obsidian.path")
                local target = Path.new(opts.path)
                local from = Path.new(current_dir)
                local rel = target:relative_to(from)

                return string.format("[%s](%s)", opts.label, rel)
            end,
            })
        end
    }
