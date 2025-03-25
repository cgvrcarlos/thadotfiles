return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	config = function()
		require("notify").setup({
			merge_duplicates = true,
			background_colour = "#000000",
			timeout = 5000,
			render = "wrapped-compact",
		})
	end,
}
