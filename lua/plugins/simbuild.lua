return {
    link = { src = "sincngraeme/simbuild.nvim", version = "main" },
    config = function()
        local simbuild = require("simbuild")
        simbuild.setup({
            ["Make"]    = "make",
            ["Cmake"]   = "cmake",
            ["CMake"]   = "cmake",
            ["Cargo"]   = "cargo",
            ["Gcc"]     = "gcc",
            ["Git"]     = "git",
            ["Gpp"]     = "g++",
            ["Clang"]   = "clang",
            ["Define"]  = "define",
            ["Go"]      = "go",
            ["Bash"]    = "bash",
        })
        vim.api.nvim_create_user_command('SimbuildRefresh', function() 
            simbuild.refresh()
        end, {})
    end
}
