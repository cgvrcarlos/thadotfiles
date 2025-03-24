return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-file-browser.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{
			";f",
			function()
				local builtin = require("telescope.builtin")

				builtin.find_files({
					no_ignore = false,
					hidden = true,
				})
			end,
			desc = "List files in current directory",
		},
		{
			";g",
			function()
				local builtin = require("telescope.builtin")
				builtin.live_grep()
			end,
			desc = "Search for a string in your current directory",
		},
		{
			"\\\\",
			function()
				local builtin = require("telescope.builtin")
				builtin.buffers()
			end,
			desc = "List open buffers",
		},
		{
			";;",
			function()
				local builtin = require("telescope.builtin")
				builtin.resume()
			end,
			desc = "Resume the last telescope picker",
		},
		{
			";d",
			function()
				local builtin = require("telescope.builtin")
				builtin.diagnostics()
			end,
			desc = "List for all open buffers or a specific buffer",
		},
		{
			";b",
			function()
				local builtin = require("telescope.builtin")
				builtin.builtin()
			end,
			desc = "List all built-in functions",
		},
		{
			";c",
			function()
				local builtin = require("telescope.builtin")
				builtin.commands()
			end,
			desc = "List all commands",
		},
		{
			";h",
			function()
				local builtin = require("telescope.builtin")
				builtin.help_tags()
			end,
			desc = "List all help tags",
		},
		{
			";a",
			function()
				local builtin = require("telescope.builtin")
				builtin.treesitter()
			end,
			desc = "List functions, variables, etc. from treesitter",
		},
		{
			"fb",
			function()
				local telescope = require("telescope")

				local function telescope_buffer_dir()
					return vim.fn.expand("%:p:h")
				end

				telescope.extensions.file_browser.file_browser({
					path = "%:p:h",
					cwd = telescope_buffer_dir(),
					respect_gitignore = false,
					hidden = true,
					grouped = true,
					previewer = false,
					initial_mode = "normal",
					layout_config = {
						height = 40,
					},
				})
			end,
			desc = "Open file browser in current buffer's directory",
		},
	},
	config = function()
		local telescope = require("telescope")
		local fb_actions = telescope.extensions.file_browser.actions

		telescope.setup({
			defaults = {
				wrap_results = true,
				layout_strategy = "horizontal",
				preview = false,
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				wimblend = 0,
				mappings = {
					["i"] = {
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
					},
				},
			},
			pickers = {
				diagnostics = {
					theme = "ivy",
					initial_mode = "normal",
					layout_config = {
						preview_cutoff = 9999,
					},
				},
			},
			extensions = {
				file_browser = {
					theme = "dropdown",
					hijack_netrw = true,
					mappings = {
						["n"] = {
							["N"] = fb_actions.create,
							["h"] = fb_actions.goto_parent_dir,
						},
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("file_browser")
	end,
}
