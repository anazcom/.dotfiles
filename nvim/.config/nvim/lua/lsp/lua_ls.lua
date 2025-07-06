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
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	opts = function(_, opts)
		if opts.ensured_installed then
			table.insert(opts.ensured_installed, { "lua-language-server", "stylua" })
		end
	end,
}
