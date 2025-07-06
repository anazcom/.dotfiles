local dap_icons = require("utils.icons").dap

return {

	"mfussenegger/nvim-dap",
	config = function()
		vim.keymap.set("n", "<F5>", function()
			require("dap").continue()
		end)
		vim.keymap.set("n", "<F10>", function()
			require("dap").step_over()
		end)
		vim.keymap.set("n", "<F11>", function()
			require("dap").step_into()
		end)
		vim.keymap.set("n", "<F12>", function()
			require("dap").step_out()
		end)
		vim.keymap.set("n", "<Leader>bb", function()
			require("dap").toggle_breakpoint()
		end)
		vim.keymap.set("n", "<Leader>bl", function()
			require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end)
		vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
			require("dap.ui.widgets").hover()
		end)
		vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
			require("dap.ui.widgets").preview()
		end)
		vim.keymap.set("n", "<Leader>df", function()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.frames)
		end)
		vim.keymap.set("n", "<Leader>ds", function()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.scopes)
		end)

		vim.fn.sign_define("DapBreakpoint", { text = dap_icons.Breakpoint, texthl = "ErrorMsg", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = dap_icons.BreakpointCondition, texthl = "ErrorMsg", linehl = "", numhl = "" }
		)
		vim.fn.sign_define("DapLogPoint", { text = dap_icons.BreakpointLog, texthl = "ErrorMsg", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = dap_icons.BreakpointStopped, texthl = "ErrorMsg",  linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapBreakpointRejected",
			{ text = dap_icons.BreakpointRejected, texthl = "ErrorMsg", linehl = "", numhl = "" }
		)
	end,
}
