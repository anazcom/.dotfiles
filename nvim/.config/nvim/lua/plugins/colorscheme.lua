return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = function()
        require('catppuccin').setup({
            flavour = "macchiato", -- latte, frappe, macchiato, mocha
            transparent_background = true,
            styles = {
                comments = { "italic" }, -- Change the style of comments
                conditionals = {},
            },
        })

        vim.cmd.colorscheme('catppuccin-macchiato')
    end
}
