return {
{
    "j-hui/fidget.nvim",
    opts = {
        notification = {
            window = {
                winblend = 0,
                border = 'rounded'
            }
        }
    }
},
{
    "mason-org/mason.nvim",
    opts = {
        pip = { install_args = {} },
        ui = { border = 'rounded' },
        keymaps = {
            toggle_package_expand = "<CR>",
            install_package = "i",
            update_package = "u",
            check_package_version = "c",
            update_all_packages = "U",
            check_outdated_packages = "C",
            uninstall_package = "X",
            cancel_installation = "<C-c>",
            apply_language_filter = "<C-f>",
            toggle_package_install_log = "<CR>",
            toggle_help = "g?",
        }
    }
}
}
