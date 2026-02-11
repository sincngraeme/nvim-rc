-- Function to set the default color scheme {{{
function _G.set_colorscheme(name)
    local persist = require('sincngraeme.modules.instinct')
    local ok, _ = pcall(vim.cmd, "colorscheme " .. name) -- Protected call to set it
    if ok then -- Success
        persist.set("default_colorscheme", name) -- Persist var
        vim.g.default_colorscheme = name -- Set var
        vim.notify("Default colorscheme set to " .. name)
    else
        -- Don't set
        vim.notify("Colorscheme '" .. name .. "' not found!", vim.log.levels.ERROR)
    end
end

-- Define command to call the function
vim.api.nvim_create_user_command("ColorSetDefault", function(opts)
    _G.set_colorscheme(opts.args)
end, { nargs = 1, complete = "color"}) -- Requires an argument, enables completion
-- }}}

-- Function for toggling the bg transparency {{{
function _G.toggle_bg_transparency()
    local persist = require('sincngraeme.modules.instinct')
    local transparency = vim.g.bg_transparency -- For Speed

    -- Toggle value
    if type(transparency) == 'boolean' then
        transparency = not transparency
    elseif transparency then -- Check if nil
        vim.notify("Transparency must be boolean but it is '" .. type(transparency) .. "'!", vim.log.levels.ERROR)
        return
    else
        transparency = false -- default to false
        vim.notify("Transparency was nil, defaulted to false" , vim.log.levels.WARNING)
    end

    vim.g.bg_transparency = transparency -- set the transparancy variable
    persist.set("bg_transparency", transparency) -- set the persistance
    vim.notify("Transparency set to " .. tostring(transparency) , vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("ToggleTransparency", function()
    _G.toggle_bg_transparency()
end, {}) -- }}}

-- Hot reload RC {{{
function _G.ReloadConfig()
  for name,_ in pairs(package.loaded) do
    if name:match('^sincngraeme') and not name:match('nvim-tree') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end -- }}}

-- Hot Reload Plugins {{{
function _G.ReloadPlugins()
  for name,_ in pairs(package.loaded) do
    if name:match('^plugins') and not name:match('nvim-tree') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim plugins reloaded!", vim.log.levels.INFO)
end -- }}}

-- Toggling Relative Line numbers {{{
function _G.toggle_relative_ln()
    local rn = vim.o.rnu
    vim.o.rnu = not rn
end

vim.api.nvim_create_user_command('ToggleRNU', function()
	_G.toggle_relative_ln()
end, {})
-- }}}

-- Make a new Scratch (temporary) buffer
vim.api.nvim_create_user_command('Scratch', function()
    vim.cmd("setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted")
end, {})
-- Make the current buffer Scratch (temporary) buffer
vim.api.nvim_create_user_command('ScratchNew', function()
    vim.cmd("new")
    vim.cmd("setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted")
end, {})

-- Scratch buffer for clipboard editing
function _G.CreateClipboardScratchBuffer()
    vim.cmd("Scratch")
    vim.keymap.set("n", "<leader>ww", function()
        vim.cmd("%y+")
        vim.schedule(function()
            vim.cmd("q")
        end)
    end, { buffer = true })
end

-- Toggling Quickfix window
function toggle_qf()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd("cclose")
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd("copen")
  end
end

vim.api.nvim_create_user_command("Toggleqf", function() toggle_qf() end, {})

---------------------------- Autocommands ----------------------------

-- Making sure that when we edit a command from terminal we exit on save
-- (WINCOMPATIBLE)
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "bash-fc.*",
    callback = function()
        print("Running Cmd...")
        vim.cmd("q") -- Exit when we save
   end
})
-- Stop C-z from suspending the process (WINCOMPATIBLE)
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "bash-fc.*",
    callback = function()
        print("Editing Command")
        vim.keymap.set("n", "C-z", "") -- Delete the map (does not persist)
    end
})

-- Set the statusline for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.opt_local.statusline = "%<%t %h%w%m%r %=" ..
        "%{% &ruler ? ( &rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat ) : '' %}"
    end
})


-- -- Prevent unused terminal buffers from cluttering the buffer list
-- vim.api.nvim_create_autocmd("TermClose", {
--   pattern = "*",
--   callback = function(args)
--     local buf = args.buf
--     if vim.bo[buf].buftype ~= "terminal" then
--       return
--     end
--
--     -- check if the buffer is still displayed somewhere
--     for _, win in ipairs(vim.api.nvim_list_wins()) do
--       if vim.api.nvim_win_get_buf(win) == buf then
--         return -- buffer is still visible, don't delete
--       end
--     end
--
--     -- safe to delete
--     vim.api.nvim_buf_delete(buf, { force = true })
--   end,
-- })

-- Opening make commands in terminal
vim.api.nvim_create_user_command("Mk", function(opts)
    vim.cmd("Start -wait=always make " .. table.concat(opts.fargs, " "))
end, { nargs = "*" })
