return {
    link = "idanarye/nvim-blunder",
    config = function()
        require("blunder").setup({
	   formats = {
           "^\\[FAIL\\]:.*",
           "^\\[PASS\\]:.*"
       },
	   commands_prefix = 'B',
        })
    end
}
