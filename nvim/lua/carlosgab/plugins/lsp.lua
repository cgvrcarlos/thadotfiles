-- ~/.config/nvim/lua/carlosgab/plugins/lsp.lua
return {
	{
		-- Plugins base de LSP (en uno solo)
		"williamboman/mason.nvim",

		-- Se cargará cuando abras o crees un buffer, para no demorar el arranque
		event = { "BufReadPre", "BufNewFile" },

		-- Declaramos todas las dependencias necesarias en un solo bloque
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			-- Estos dos son opcionales, pero los tenías en tu config
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/neodev.nvim", opts = {} },
		},

		-- Un solo "config" para gobernarlos a todos
		config = function()
			------------------------------------------------------------------------
			-- 1) mason.nvim
			------------------------------------------------------------------------
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "",
						package_pending = "",
						package_outdated = "",
					},
				},
			})

			------------------------------------------------------------------------
			-- 2) mason-lspconfig
			------------------------------------------------------------------------
			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({
				automatic_installation = true,
				ensure_installed = {
					"html",
					"lua_ls",
					"pyright",
					"ruff",
					"ts_ls",
					-- Agrega aquí los servidores LSP que quieras instalar
				},
			})

			------------------------------------------------------------------------
			-- 3) mason-tool-installer (opcional)
			------------------------------------------------------------------------
			local mason_tool_installer = require("mason-tool-installer")
			mason_tool_installer.setup({
				ensure_installed = {
					"prettier",
					"stylua",
					"eslint_d",
					-- Otras herramientas que desees
				},
			})

			------------------------------------------------------------------------
			-- 4) nvim-lspconfig
			------------------------------------------------------------------------
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			-- Capabilities para autocompletado
			local capabilities = cmp_nvim_lsp.default_capabilities()

			------------------------------------------------------------------------
			-- Autocomandos y Keymaps al "attach" de LSP
			------------------------------------------------------------------------
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }

					-- Aquí pones tus mapeos:
					opts.desc = "Show LSP references"
					vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

					opts.desc = "Go to declaration"
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

					opts.desc = "Show LSP definitions"
					vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

					opts.desc = "Show LSP implementations"
					vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

					opts.desc = "Show LSP type definitions"
					vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

					opts.desc = "See code actions"
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

					opts.desc = "Smart rename"
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

					opts.desc = "Show buffer diagnostics"
					vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

					opts.desc = "Show line diagnostics"
					vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

					opts.desc = "Go to previous diagnostic"
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

					opts.desc = "Go to next diagnostic"
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

					opts.desc = "Show documentation"
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

					opts.desc = "Restart LSP"
					vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
				end,
			})

			------------------------------------------------------------------------
			-- Signos para Diagnostics
			------------------------------------------------------------------------
			local signs = { Error = "", Warning = "", Hint = "󰠠", Information = "" }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			------------------------------------------------------------------------
			-- Handlers de mason-lspconfig (configuración por servidor)
			------------------------------------------------------------------------
			mason_lspconfig.setup_handlers({

				-- Handler genérico (todos los servers que no sean override abajo)
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,

				-- Config extra para "lua_ls"
				["lua_ls"] = function()
					lspconfig["lua_ls"].setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
								completion = {
									callSnippet = "Replace",
								},
							},
						},
					})
				end,

				-- Config extra para "pyright"
				["pyright"] = function()
					lspconfig["pyright"].setup({
						capabilities = capabilities,
						settings = {
							pyright = { disableOrganizeImports = false },
							python = {
								analysis = {
									ignore = { "*" },
								},
							},
						},
					})
				end,

				-- Config extra para 'ts_ls'
				["ts_ls"] = function()
					lspconfig["ts_ls"].setup({
						capabilities = capabilities,
						root_dir = lspconfig.util.root_pattern(
							"package.json",
							"tsconfig.json",
							"jsconfig.json",
							".git"
						),
					})
				end,

				-- Agrega más overrides para otros servidores si los necesitas
			})
		end,
	},
}
