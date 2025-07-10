local dap_icons = require("utils.icons").dap

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- taken from https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/plugins/dap.lua
		{
			"igorlfs/nvim-dap-view",

			---@module 'dap-view'
			---@type dapview.Config
			opts = {
				winbar = {
					sections = { "scopes", "breakpoints", "threads", "exceptions", "repl", "console" },
					default_section = "scopes",
				},
				windows = { height = 18 },
				-- When jumping through the call stack, try to switch to the buffer if already open in
				-- a window, else use the last window to open the buffer.
				switchbuf = "usetab,uselast",
			},
		},

		-- Virtual Text when Debugging
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = { virt_text_pos = "eol" },
		},
	},
	keys = {
            -- stylua: ignore start
            { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle breakpoint' },
            { '<leader>ds', function() require('dap').continue() end, desc = 'Continue' },
            { '<M-l>', function() require('dap').step_over() end, desc = 'Step over' },
            { '<M-j>', function() require('dap').step_into() end, desc = 'Step into' },
		-- stylua: ignore end
	},
	config = function()
		local dap = require("dap")
		local dv = require("dap-view")

		-- Automatically open the UI when a new debug session is created.
		dap.listeners.before.attach["dap-view-config"] = function() dv.open() end
		dap.listeners.before.launch["dap-view-config"] = function() dv.open() end
		dap.listeners.before.event_terminated["dap-view-config"] = function() dv.close() end
		dap.listeners.before.event_exited["dap-view-config"] = function() dv.close() end

		vim.fn.sign_define("DapBreakpoint", { text = dap_icons.Breakpoint, texthl = "ErrorMsg" })
		vim.fn.sign_define("DapBreakpointCondition", { text = dap_icons.BreakpointCondition, texthl = "ErrorMsg" })
		vim.fn.sign_define("DapLogPoint", { text = dap_icons.BreakpointLog, texthl = "ErrorMsg" })
		vim.fn.sign_define("DapStopped", { text = dap_icons.BreakpointStopped, texthl = "ErrorMsg" })
		vim.fn.sign_define("DapBreakpointRejected", { text = dap_icons.BreakpointRejected, texthl = "ErrorMsg" })
	end,
}
