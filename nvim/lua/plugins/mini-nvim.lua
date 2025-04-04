return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		require("mini.ai").setup()
		require("mini.comment").setup()
		require("mini.move").setup()
		require("mini.pairs").setup()
		require("mini.surround").setup()

		require("mini.files").setup()

		require("mini.indentscope").setup()
		require("mini.statusline").setup()
	end,
}
