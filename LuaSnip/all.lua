local ls = require("luasnip")
return {
    -- TODO
    ls.snippet("TD", { 
        ls.text_node("TODO: ") 
    }),
    -- WARNING
    ls.snippet("WA", { 
        ls.text_node("WARNING: ") 
    }),
    -- NOTE
    ls.snippet("NO", { 
        ls.text_node("NOTE: ") 
    }),
}
