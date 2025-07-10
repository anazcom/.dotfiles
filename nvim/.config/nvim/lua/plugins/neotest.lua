--- This function will load all adapters that were added
--- on each language configuration
---
--- @param opts table opts pass in function
local function load_adapters(opts)
	if not opts.adapters then
		return
	end

	local adapters = {}
	for name, config in pairs(opts.adapters or {}) do
		if type(name) ~= "string" then
			error("Incorrect type name for adapter " .. name .. " found " .. type(name))
		end

		if type(config) ~= "table" then
			error("Incorrect config provided for adapter " .. name .. " found " .. type(config))
		end

		local adapter = require(name)
		local meta = getmetatable(adapter)
		if adapter.setup then
			adapter.setup(config)
		elseif adapter.adapter then
			adapter.adapter(config)
			adapter = adapter.adapter
		elseif meta and meta.__call then
			adapter = adapter(config)
		else
			error("Adapter " .. name .. " does not support setup")
		end

		adapters[#adapters + 1] = adapter
	end

	opts.adapters = adapters
end

---@type LazyPluginSpec
return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function(_, opts)
		local keymap = vim.keymap.set
		local function debugging()
			require("neotest").run.run(vim.fn.expand("%"))
		end
        --stylua: ignore start
        keymap("n", "<leader>t", "", { desc = "+test" })
        keymap("n", "<leader>tf", debugging --[[function() require("neotest").run.run(vim.fn.expand("%")) end]], { desc = "Run File (Neotest)" })
        keymap("n", "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, { desc = "Run All Test Files (Neotest)"})
        keymap("n", "<leader>tr", function() require("neotest").run.run() end, { desc = "Run Nearest (Neotest)" } )
        keymap("n", "<leader>ts", function() require("neotest").summary.toggle() end, { desc = "Toggle Summary (Neotest)" })
        keymap("n", "<leader>to", function() require("neotest").output_panel.toggle() end, { desc = "Toggle Output Panel (Neotest)" })
        keymap("n", "<leader>tq", function() require("neotest").run.stop() end, { desc = "Stop (Neotest)" })
        keymap("n", "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, { desc = "Toggle Watch (Neotest)" })
        --stylua: ignore start

        load_adapters(opts)
        require("neotest").setup(opts)
	end,
}
