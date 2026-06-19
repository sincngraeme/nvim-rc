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
            ["Build"] = "./scripts/build_rpi.sh --hardware can0 125000",
        })
    end
}
