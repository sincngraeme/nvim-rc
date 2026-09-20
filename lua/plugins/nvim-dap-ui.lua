return {
    link = "rcarriga/nvim-dap-ui",
    config = function()
        local dapui = require("dapui")
        dapui.setup({
            icons = {
                collapsed = "+",
                current_frame = "+",
                expanded = "-",
            },
            layouts = {
                {   -- Side panel
                    elements = {
                        "scopes",
                        "stacks",
                        "breakpoints",
                        "watches",
                    },
                    size = 40,  -- Width
                    position = "left",
                },
                {   -- Bottom panel
                    elements = {
                        -- "repl",
                        { id = "console", size = 0.7 },
                    },
                    size = 12,  -- Height
                    position = "bottom"
                },
            }
        })
    end
}
