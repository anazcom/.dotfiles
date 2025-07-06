vim.lsp.config("lua-language-server", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_dir = vim.fs.root(0, {
		".luarc.json",
		".luarc.jsonc",
		".luacheckrc",
		".stylua.toml",
		"stylua.toml",
		"selene.toml",
		"selene.yml",
		".git",
	}),
	settings = {
		Lua = {
			completion = { callSnippet = "Replace" },
			-- Using stylua for formatting.
			format = { enable = false },
			hint = {
				enable = true,
				arrayIndex = "Disable",
			},
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					"${3rd}/luv/library",
				},
			},
		},
	},
})

vim.lsp.enable("lua-language-server", true)

return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			if opts.ensured_installed then
				table.insert(opts.ensured_installed, { "lua-language-server", "stylua", "local-lua-debugger-vscode" })
			end
		end,
	},
	{
		"mfussenegger/nvim-dap",
		opts = function(_, opts)
			local dap = require("dap")
			local debugger = vim.fn.stdpath("data")
				.. "/mason/packages/local-lua-debugger-vscode/extension/extension/debugAdapter.js"

			dap.adapters.lua = {
				type = "executable",
				command = "node",
				args = { debugger },
			}

			dap.configurations.lua = {
				{
					type = "lua",
					request = "attach",
					name = "Run this file",
					start_neovim = {},
				},
				{
					type = "lua",
					request = "attach",
					name = "Attach to running Neovim instance (port = 8086)",
					port = 8086,
				},
			}

			return opts
		end,
	},
}
