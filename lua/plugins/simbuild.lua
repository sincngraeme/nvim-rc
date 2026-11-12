return {
    link = "sincngraeme/simbuild.nvim",
    config = function()
        local simbuild = require("simbuild")
        simbuild.setup({
            ["Make"] = "make",
            ["Cmake"] = "cmake",
            ["CMake"] = "cmake",
            ["Cargo"] = "cargo",
            ["Gcc"] = "gcc",
            ["Gpp"] = "g++",
            ["Clang"] = "clang",
            ["Just"] = "just",
        })

        vim.api.nvim_create_user_command("SimbuildRefresh", function()
            simbuild.refresh()
        end, {})
    end
}
