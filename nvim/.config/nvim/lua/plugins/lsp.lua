local function config_diagnostics()
	local diagnostic_icons = require("utils.icons").diagnostics

	---@type vim.diagnostic.Opts[]
	vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = diagnostic_icons.ERROR,
				[vim.diagnostic.severity.WARN] = diagnostic_icons.WARN,
				[vim.diagnostic.severity.INFO] = diagnostic_icons.INFO,
				[vim.diagnostic.severity.HINT] = diagnostic_icons.HINT,
			},
		},
		virtual_text = {
			prefix = "",
			spacing = 2,
			float = {
				source = "if_many",
				-- Show severity icons as prefixes.
				prefix = function(diag)
					local level = vim.diagnostic.severity[diag.severity]
					local prefix = string.format(" %s ", diagnostic_icons[level])
					return prefix, "Diagnostic" .. level:gsub("^%l", string.upper)
				end,
			},
		},
		float = { border = "rounded" },
	})
end

--- Setup keymaps for Client when it attaches to a buffer
---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
	---@param lhs string
	---@param rhs string|function
	---@param desc string
	---@param mode? string|string[]
	local function keymap(lhs, rhs, desc, mode)
		mode = mode or "n"
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP " .. desc })
	end

	local methods = vim.lsp.protocol.Methods
	local severityERROR = vim.diagnostic.severity.ERROR

	keymap("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
	keymap("grr", "<cmd>FzfLua lsp_references<cr>", "References")
	keymap("gy", "<cmd>FzfLua lsp_typedefs<cr>", "Type Definitions")
	keymap("<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", "Document symbols")
	keymap("[d", function()
		vim.diagnostic.jump({ count = -1 })
	end, "Previous diagnostic")
	keymap("]d", function()
		vim.diagnostic.jump({ count = 1 })
	end, "Next diagnostic")
	keymap("[e", function()
		vim.diagnostic.jump({ count = -1, severity = severityERROR })
	end, "Previous error")
	keymap("]e", function()
		vim.diagnostic.jump({ count = 1, severity = severityERROR })
	end, "Next error")

	if client:supports_method(methods.textDocument_definition) then
		keymap("gd", function()
			require("fzf-lua").lsp_definitions({ jump1 = true })
		end, "Go to definition")
		keymap("gD", function()
			require("fzf-lua").lsp_definitions({ jump1 = false })
		end, "Peek definition")
	end

    --only applicable for TS
	if client:supports_method("_typescript.organizeImports") then
		keymap("oi", function()
			local params = {
				command = "_typescript.organizeImports",
				arguments = { vim.api.nvim_buf_get_name(bufnr) },
				title = "Organize Imports",
			}
			vim.lsp.buf.execute_command(params)
		end, "Organize Imports (TS)")
	end

	if client:supports_method(methods.textDocument_signatureHelp) then
		keymap("<C-k>", function()
			vim.lsp.buf.signature_help()
		end, "Signature help", "i")
	end

	if client:supports_method(methods.textDocument_documentHighlight) then
		local under_cursor_highlights_group =
			vim.api.nvim_create_augroup("anazcom/cursor_highlights", { clear = false })
		vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
			group = under_cursor_highlights_group,
			desc = "Highlight references under the cursor",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
			group = under_cursor_highlights_group,
			desc = "Clear highlight references",
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end

	-- Configure Capabilities
	-- Need to include blink capabilities within LSP Client
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local blink_capabilities = require("blink.cmp").get_lsp_capabilities(nil, true)
	capabilities = vim.tbl_deep_extend("force", capabilities, blink_capabilities)
end

return {
	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				window = {
					winblend = 0,
					border = "rounded",
				},
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			opts = {
				pip = { install_args = {} },
				ui = { border = "rounded" },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			config_diagnostics()

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("anazcom/lsp-attached", { clear = true }),
				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client then
						on_attach(client, event.buf)
					end
				end,
			})
		end,
	},
}
