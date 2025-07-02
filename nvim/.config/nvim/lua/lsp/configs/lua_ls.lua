
---@type vim.lsp.ClientConfig
return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = vim.fs.root(0, { '.luarc.json', '.luarc.jsonc', '.git' }) ,
    settings = {
        Lua = {
            completion = { callSnippet = 'Replace' },
            -- Using stylua for formatting.
            format = { enable = false },
            hint = {
                enable = true,
                arrayIndex = 'Disable',
            },
            runtime = {
                version = 'LuaJIT',
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    '${3rd}/luv/library',
                },
            },
        },
    },
}
