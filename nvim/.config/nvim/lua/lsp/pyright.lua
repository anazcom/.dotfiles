vim.lsp.config("pyright", {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_dir = vim.fs.root(0, {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".venv",
		".git",
	}),
	single_file_support = true,
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
})

vim.lsp.enable("pyright", true)

return {
	"whoissethdaniel/mason-tool-installer.nvim",
	opts = function(_, opts)
		if opts.ensured_installed then
			table.insert(opts.ensured_installed, { "pyright", "ruff", "debugpy" })
		end
	end,
}
