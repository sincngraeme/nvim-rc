return {
    link = "rcarriga/nvim-dap-ui",
    config = function()
        local dapui = require("dapui")
        dapui.setup({
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
                        "console",
                        "terminal",
                    },
                    size = 15,  -- Height
                    position = "bottom"
                },
            }
        })
    end
}
