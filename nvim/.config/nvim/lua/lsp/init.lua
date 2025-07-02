--- Return all Client Config Tables stored in lsp.configs
--- @return vim.lsp.ClientConfig[]
local function get_server_configs()

    local module = 'lsp.configs'
    local configs = {}
    local files = vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/" .. module:gsub("%.", "/"), "*.lua", false, true)

    for _, file in ipairs(files) do
      local filename = vim.fn.fnamemodify(file, ":t:r") -- getting filename without extension
      local ok, result = pcall(require, module .. "." .. filename)
      if ok then
        table.insert(configs, result)
      else
        vim.notify(string.format("Error loading table from %s: %s %s", filename, result, vim.log.levels.ERROR))
      end
    end
return configs
end

--- Configure Diagnostics
local function configure_diagnostics()
    local diagnostic_icons = require('utils.icons').diagnostics
    vim.diagnostic.config({
        ---@type vim.diagnostic.Opts
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = diagnostic_icons.ERROR,
                    [vim.diagnostic.severity.WARN] = diagnostic_icons.WARN,
                    [vim.diagnostic.severity.INFO] = diagnostic_icons.INFO,
                    [vim.diagnostic.severity.HINT] = diagnostic_icons.HINT
               },
            },
            virtual_text = {
                prefix = '',
                spacing = 2,
                float = {
                source = 'if_many',
                -- Show severity icons as prefixes.
                prefix = function(diag)
                    local level = vim.diagnostic.severity[diag.severity]
                    local prefix = string.format(' %s ', diagnostic_icons[level])
                    return prefix, 'Diagnostic' .. level:gsub('^%l', string.upper)
                end,
            },
        },
        float = {
            border = 'rounded'
        }
    })
end

--- Configure Handlers
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

--- Setup keymaps for Client when it attaches to a buffer
---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)

    ---@param lhs string
    ---@param rhs string|function
    ---@param desc string
    ---@param mode? string|string[]
    local function keymap(lhs, rhs, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    local methods = vim.lsp.protocol.Methods

    keymap("<leader>ca", vim.lsp.buf.code_action, "LSP Code Action", { "n", "x" })
    --keymap('grr', '<cmd>FzfLua lsp_references<cr>', 'vim.lsp.buf.references()')
    keymap('gD', vim.lsp.buf.references , 'vim.lsp.buf.references()')
    --keymap('gy', '<cmd>FzfLua lsp_typedefs<cr>', 'Go to type definition')
    keymap('gy', vim.lsp.buf.type_definition, 'Go to type definition')
    --keymap('<leader>fs', '<cmd>FzfLua lsp_document_symbols<cr>', 'Document symbols')
    keymap('<leader>fs', vim.lsp.buf.document_symbol , 'Document symbols')

    keymap('[d', function()
        vim.diagnostic.jump { count = -1 }
    end, 'Previous diagnostic')
    keymap(']d', function()
        vim.diagnostic.jump { count = 1 }
    end, 'Next diagnostic')
    keymap('[e', function()
        vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR }
    end, 'Previous error')
    keymap(']e', function()
        vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR }
    end, 'Next error')

     if client.supports_method(methods.textDocument_definition) then
        keymap('gd', function()
            vim.lsp.buf.definition()
            --require('fzf-lua').lsp_definitions { jump1 = true }
        end, 'Go to definition')
        keymap('gD', function()
            --require('fzf-lua').lsp_definitions { jump1 = false }
        end, 'Peek definition')
    end

     if client.supports_method(methods.textDocument_signatureHelp) then
        keymap('<C-k>', function()
            -- Close the completion menu first (if open).
            -- if require('blink.cmp.completion.windows.menu').win:is_open() then
            --     require('blink.cmp').hide()
            -- end

            vim.lsp.buf.signature_help()
        end, 'Signature help', 'i')
    end

    if client.supports_method(methods.textDocument_documentHighlight) then
        local under_cursor_highlights_group =
            vim.api.nvim_create_augroup('anazcom/cursor_highlights', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave' }, {
            group = under_cursor_highlights_group,
            desc = 'Highlight references under the cursor',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter', 'BufLeave' }, {
            group = under_cursor_highlights_group,
            desc = 'Clear highlight references',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

configure_diagnostics()

--- Set up LSP servers based on FileType
vim.api.nvim_create_autocmd({'FileType'}, {
    callback = function()
        local server_configs = get_server_configs()
        local filetype = vim.bo[0].filetype

        for _, config in pairs(server_configs) do
            if config["filetypes"] and vim.list_contains( config["filetypes"] , filetype ) then
                vim.lsp.start(config)
            end
        end
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Configure LSP keymaps',
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- I don't think this can happen but it's a wild world out there.
        if not client then
            return
        end

        on_attach(client, args.buf)
    end,
})
