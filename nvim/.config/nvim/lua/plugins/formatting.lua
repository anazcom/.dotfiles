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
			python = { "ruff" },
			javascript = { "prettier", stop_after_first = true },
			typescript = { "prettier", stop_after_first = true },
			html = { "prettier", stop_after_first = true },
			css = { "prettier", stop_after_first = true },
		},
	},
}
