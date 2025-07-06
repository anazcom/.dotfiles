vim.lsp.config("ts_ls", {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"htmlangular",
	},
	root_dir = vim.fs.root(0, { "tsconfig.json", "jsconfig.json", "package.json", ".git" }),
	single_file_support = true,
})

vim.lsp.enable("ts_ls", true)

return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	opts = function(_, opts)
		if opts.ensured_installed then
			table.insert(opts.ensured_installed, { "typescript-language-server", "prettier" })
		end
	end,
}
