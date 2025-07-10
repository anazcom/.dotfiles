return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>fb",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = {
				"ruff_fix", -- To fix auto-fixable lint errors.
				"ruff_format", -- To run the Ruff formatter.
				"ruff_organize_imports", -- To organize the imports.
			},
			javascript = { "prettier", stop_after_first = true },
			typescript = { "prettier", stop_after_first = true },
			html = { "prettier", stop_after_first = true },
			htmlangular = { "prettier", stop_after_first = true },
			css = { "prettier", stop_after_first = true },
		},
	},
}
