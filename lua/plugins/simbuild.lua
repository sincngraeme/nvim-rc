return {
    link = "sincngraeme/simbuild.nvim",
    config = function()
        require("simbuild").setup({
            ["Make"] = "make",
            ["Cargo"] = "cargo",
            ["Gcc"] = "gcc",
            ["Clang"] = "clang",
        })
    end
}
