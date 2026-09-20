local consoleBuf = 0
local session

return {
    link = "mfussenegger/nvim-dap",
    config = function()
        local dap = require('dap')
        local ui = require('dapui')
        -- telescope requirements for picking executable
        local builtin = require("telescope.builtin")
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        -- open telescope picker to pick an executable to debug
        local function pick_program()
            return coroutine.create(function(co)
                builtin.find_files({
                    prompt_title = "Select executable",
                    no_ignore = true,

                    attach_mappings = function(prompt_bufnr)
                        actions.select_default:replace(function()
                            local selection = action_state.get_selected_entry()

                            actions.close(prompt_bufnr)

                            if selection then
                                local path = selection.path or selection.value
                                coroutine.resume(co, vim.fn.fnamemodify(path, ":p"))
                            end
                        end)

                        return true
                    end,
                })
            end)
        end

        -- Open Gdb Console window
        local function newGdbConsoleWindow()
            session = dap.session().adapter.command
            if not vim.g.is_win and session == "gdb" then
                -- create window
                local console = NewEmptyConsole()
                print(console.buf)
                -- open gdb
                vim.defer_fn(function()
                    dap.repl.execute("new-ui console " .. console.pty)
                end, 300)
                return console.buf
            end
        end

        -- Close Gdb Console Window
        local function closeGdbConsoleWindow()
            if not vim.g.is_win and session == "gdb" then
                if vim.api.nvim_buf_is_valid(consoleBuf) then
                    vim.api.nvim_buf_delete(consoleBuf, { force = true })
                end
            end
        end

        dap.adapters.c = {
            type = 'executable',
            command = 'gdb',
            args = {
                '--interpreter=dap',
            },
        }

        dap.configurations.c = {
            {
                name = "Launch file",
                type = "cpp",
                request = "launch",
                program = pick_program,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
            },
            {
                name = "Select and attach to process",
                type = "gdb",
                request = "attach",
                program = pick_program,
                pid = function()
                  local name = vim.fn.input('Executable name (filter): ')
                  return require("dap.utils").pick_process({ filter = name })
                end,
                cwd = '${workspaceFolder}'
              },
              {
                name = 'Attach to gdbserver :1234',
                type = 'gdb',
                request = 'attach',
                target = 'localhost:1234',
                program = pick_program,
                cwd = '${workspaceFolder}'
              }
        }

        dap.adapters.cpp = dap.adapters.c
        dap.configurations.cpp = dap.configurations.c
        dap.adapters.rust = dap.adapters.c
        dap.configurations.rust = dap.configurations.c

        dap.listeners.before.attach.dapui_config = function()
            ui.open()
            consoleBuf = newGdbConsoleWindow()
        end
        dap.listeners.before.launch.dapui_config = function()
            ui.open()
            consoleBuf = newGdbConsoleWindow()
        end
        dap.listeners.before['event_terminated']['dapui_config'] = function()
            ui.close()
            closeGdbConsoleWindow()
        end
        dap.listeners.before['event_exited']['dapui_config'] = function()
            ui.close()
            closeGdbConsoleWindow()
        end
    end
}
