return {
    link = "mfussenegger/nvim-dap",
    config = function()
        local dap = require('dap')

        dap.adapters.c = {
            type = 'executable',
            command = 'gdb',
            args = { '--interpreter=dap' },
        }

        dap.configurations.c = {
            {
                name = "Launch file",
                type = "cpp",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to exe: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
            },
        }
        dap.adapters.cpp = dap.adapters.c
        dap.configurations.cpp = dap.configurations.c
    end
}
