return {
	"ibhagwan/fzf-lua",
	dependencies = { "echasnovski/mini.icons", opts = {} },
	opts = {},
	keys = {
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
			desc = "[F]ind [F]iles ",
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "[F]ind [G]rep",
		},
		{
			"<leader>fc",
			function()
				require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "[F]ind [C]onfiguration",
		},
		{
			"<leader>fh",
			function()
				require("fzf-lua").helptags()
			end,
			desc = "[F]ind [H]elp",
		},
		{
			"<leader>fb",
			function()
				require("fzf-lua").builtin()
			end,
			desc = "[F]ind [B]uiltin FZF",
		},
		{
			"<leader>fw",
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "[F]ind current [W]ord",
		},
		{
			"<leader>fW",
			function()
				require("fzf-lua").grep_cWORD()
			end,
			desc = "[F]ind current [W]ORD",
		},
		{
			"<leader>fd",
			function()
				require("fzf-lua").diagnostics_document()
			end,
			desc = "[F]ind [D]iagnostics",
		},
		{
			"<leader>fr",
			function()
				require("fzf-lua").resume()
			end,
			desc = "[F]ind [R]esume",
		},
		{
			"<leader>fo",
			function()
				require("fzf-lua").oldfiles()
			end,
			desc = "[F]ind [O]ld files",
		},
		{
			"<leader><leader>",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "[F]ind [B]uffers",
		},
		{
			"<leader>/",
			function()
				require("fzf-lua").lgrep_curbuf()
			end,
			desc = "[/] Live grep the current file",
		},
	},
}
