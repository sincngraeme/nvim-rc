return { 
    'hrsh7th/nvim-cmp',

    config = function()
        local cmp = require('cmp')
        local cmp_select = {behavior = cmp.SelectBehavior.Select}

        cmp.setup({
          sources = cmp.config.sources({
            {name = 'nvim_lsp'},  
          }, {
            {name = 'buffer'},
          }),
          mapping = cmp.mapping.preset.insert({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<CR>'] = cmp.mapping.confirm({select = true}),
            ['<C-Space>'] = cmp.mapping.complete(),
          }),
        })
    end,
}
