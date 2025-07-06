-- Angular requires a node_modules directory to probe for @angular/language-service and typescript
-- in order to use your projects configured versions.

local function get_angular_core_version(root_dir)
	local project_root = vim.fs.dirname(vim.fs.find("node_modules", { path = root_dir, upward = true })[1])

	if not project_root then
		return ""
	end

	local package_json = project_root .. "/package.json"
	if not vim.uv.fs_stat(package_json) then
		return ""
	end

	local contents = io.open(package_json):read("*a")
	local json = vim.json.decode(contents)
	if not json.dependencies then
		return ""
	end

	local angular_core_version = json.dependencies["@angular/core"]
	angular_core_version = angular_core_version and angular_core_version:match("%d+%.%d+%.%d+")

	print(string.format("angular version %s", angular_core_version))
	return angular_core_version
end

local default_ng_dir = vim.fn.stdpath("data")
	.. "/mason/packages/angular-language-server/node_modules/@angular/language-server/node_modules"
local default_ts_dir = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules"
local default_angular_core_version = get_angular_core_version(vim.fn.getcwd())

vim.lsp.config("angularls", {
	cmd = {
		"ngserver",
		"--stdio",
		"--tsProbeLocations",
		default_ts_dir,
		"--ngProbeLocations",
		default_ng_dir,
		"--angularCoreVersion",
		default_angular_core_version,
	},
	filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
	root_dir = vim.fs.root(0, { "angular.json" }),
})

vim.lsp.enable("angularls", true)

require("language.typescript")

return {
	{
		"whoissethdaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			if opts.ensured_installed then
				table.insert(opts.ensured_installed, { "angular-language-server", "prettier" })
			end
		end,
	},
}
