return {
	"saghen/blink.cmp",
	version = "1.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			["<Tab>"] = { "accept", "fallback" },
			["<C-\\>"] = { "hide", "fallback" },
			["<C-j>"] = { "select_next", "snippet_forward", "scroll_documentation_down", "fallback" },
			["<C-k>"] = { "select_prev", "scroll_documentation_up", "fallback" },
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			menu = { border = "rounded" },
			list = {
				-- Insert items while navigating the completion list.
				selection = {
					preselect = true,
					auto_insert = true,
				},
				max_items = 10,
			},
			documentation = {
				auto_show = false,
				window = { border = "rounded" },
			},
		},
		signature = {
			window = {
				border = "rounded",
			},
		},

		sources = {
			default = { "lsp", "path", "snippets" },
		},
	},
}
