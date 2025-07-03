return {
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {
            theme = 'catppuccin',
            component_separators = { left = '|', right = '|'},
            section_separators = { left = '', right = ''},
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics'},
            lualine_c = { 'filename' },
            lualine_x = { 'encoding','filetype' },
            lualine_y = { 'lsp_status' },--{'progress'},
            lualine_z = { 'location' }
      },
      inactive_sections = {
          lualine_c = { 'filename' }
      }
    }
}
        -- options = {
        --     icons_enabled = true,
        --     theme = { 'catppuccin' },
        --     component_separators = { left = "|", right = "|" },
        --     section_separators = { left = "", right = "" },
        -- }
      --   options = {
      --       icons_enabled = true,
      --   },
      --   print("geyyyy"),
