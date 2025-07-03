return {
  'saghen/blink.cmp',
  -- dependencies = { 'LuaSnip' },
  event = 'InsertEnter',
  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
      keymap = {
        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-\\>'] = { 'hide', 'fallback' },
        ['<C-n>'] = { 'select_next', 'show' },
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<C-p>'] = { 'select_prev' },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' }
    },
    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = {
        menu = { border = 'rounded' },
        list = {
            -- Insert items while navigating the completion list.
            selection = { preselect = false, auto_insert = true },
            max_items = 10,
        },
        documentation = {
            auto_show = false,
            window = { border = 'rounded' }
        }
    },
    signature = {
        window = {
            border = 'rounded'
        }
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
  config = function(_, opts)
      require('blink.cmp').setup(opts)

      -- Extend neovim's client capabilities with the completion ones.
      vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities(nil, true) })
  end

}
