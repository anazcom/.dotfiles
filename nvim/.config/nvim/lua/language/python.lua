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

--- Return python path based on current environment
--- if environment is empty then global installation
--- @return string path Path being used
local function get_python_path()
	local cwd = vim.fn.getcwd()
	local env = os.getenv("VIRTUAL_ENV")

	local python_path = "/usr/bin/python"
	if env and vim.startswith(env, cwd) then
		python_path = env .. "/bin/python"
	end

	return python_path
end

---@type LazyPluginSpec[]
return {
	{
		"whoissethdaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			if opts.ensured_installed then
				table.insert(opts.ensured_installed, { "pyright", "ruff", "debugpy" })
			end
		end,
	},
	{
		"mfussenegger/nvim-dap",
		opts = function(_, opts)
			local dap = require("dap")
			local python_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python3"

			dap.adapters.debugpy = {
				type = "executable",
				command = python_path,
				args = { "-m", "debugpy.adapter" },
				options = {
					source_filetype = "python",
				},
			}

			dap.configurations.python = {
				{
					type = "debugpy",
					request = "launch",
					name = "file",
					program = "${file}",
					pythonPath = get_python_path(),
				},
			}
		end,
	},
	{
		"nvim-neotest/neotest",
		optional = true,
		dependencies = {
			"nvim-neotest/neotest-python",
		},
		opts = {
			adapters = {
				["neotest-python"] = {},
			}
		},
	},
}
