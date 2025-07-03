return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { '<leader>ff', '<cmd>FzfLua files<cr>', desc = 'Find files' },
    { '<leader>fg', '<cmd>FzfLua live_grep<cr>', desc = 'Grep' },
    { '<leader>fh', '<cmd>FzfLua help_tags<cr>', desc = 'Help' },
    { '<leader>gb', '<cmd>FzfLua git_branches<cr>', desc = 'Help' },
  },
  opts = function(_, opts)
    local fzf = require("fzf-lua")
    local config = fzf.config

    config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
    config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
    config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
    config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
    config.defaults.keymap.fzf["ctrl-p"] = "toggle-preview"
    config.defaults.keymap.builtin["<c-p>"] = "toggle-preview"
    config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
    config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

    return {
      winopts = {
        border = "rounded",
        preview = {
            border = "rounded",
            hidden = true,
        }
      },
  }
  end
}
