return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			textobjects = {
				select = {
					enable = false,

					lookahead = true,

					keymaps = {
						["af"] = { query = "@function.outer", desc = "Select outer function" },
						["if"] = { query = "@function.inner", desc = "Select inner function" },
						["ac"] = { query = "@class.outer", desc = "Select outer class" },
						["ic"] = { query = "@class.inner", desc = "Select inner class" },
						["ao"] = { query = "@comment.outer", desc = "Select outer comment" },
					},
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "<c-v>", -- blockwise
					},
					include_surrounding_whitespace = true,
				},
			},
		})
	end,
}
