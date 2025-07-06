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
		dependencies = {
			"jbyuki/one-small-step-for-vimkind",
			keys = {
                -- stylua: ignore start
				{ "<leader>dl", function() require("osv").launch({ port = 8086 }) end, desc = "Launch Lua Adapter" },
				--stylua: ignore end
			},
		},
		opts = function(_, opts)
			local dap = require("dap")
			local debugger = vim.fn.stdpath("data")
				.. "/mason/packages/local-lua-debugger-vscode/extension/extension/debugAdapter.js"

			dap.adapters.nlua = function(callback, config)
				callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
			end

			dap.configurations["lua"] = {
				{
					type = "nlua",
					request = "attach",
					name = "Attach to running Neovim instance",
				},
			}

			return opts
		end,
	},
}
