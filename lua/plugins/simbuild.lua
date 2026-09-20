return {
    link = "sincngraeme/simbuild.nvim",
    config = function()
        require("simbuild").setup({
            ["Make"] = "make",
            ["Cmake"] = "cmake",
            ["CMake"] = "cmake",
            ["Cargo"] = "cargo",
            ["Gcc"] = "gcc",
            ["Gpp"] = "g++",
            ["Clang"] = "clang",
            ["Build"] = "sudo ./install.bash",
        })
    end
}
