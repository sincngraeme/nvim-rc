return {
    link = "L3MON4D3/LuaSnip",
    config = function()
        local ls = require("luasnip")

        ls.config.set_config({
            history = true,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = true,
        })

        vim.keymap.set({"i", "s" }, "<C-.>", function() 
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end, {silent = true})
        vim.keymap.set({"i", "s"}, "<C-,>", function() 
            if ls.jumpable(-1) then
                ls.jump(-1) 
            end
        end, {silent = true})

        vim.keymap.set({"i", "s"}, "<C-S-n>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, {silent = true})
        vim.keymap.set({"i", "s"}, "<C-S-p>", function()
            if ls.choice_active() then
                ls.change_choice(-1)
            end
        end, {silent = true})
    
        require('luasnip.loaders.from_vscode').lazy_load()
        require('luasnip.loaders.from_lua').load({ 
            paths = vim.fn.stdpath("config") .. "/LuaSnip/"
        })
    end,
}
