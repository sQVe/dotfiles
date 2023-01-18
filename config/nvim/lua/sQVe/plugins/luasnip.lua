-- ╻  ╻ ╻┏━┓┏━┓┏┓╻╻┏━┓
-- ┃  ┃ ┃┣━┫┗━┓┃┗┫┃┣━┛
-- ┗━╸┗━┛╹ ╹┗━┛╹ ╹╹╹
-- Snippet support.

local M = {
  'L3MON4D3/LuaSnip',
  keys = {
    {
      '<C-l>',
      function()
        require('luasnip').expand()
      end,
      mode = { 'i' },
    },
  },
}

M.opts = {
  history = true,
  delete_check_events = 'TextChanged',
}

M.config = function(_, opts)
  require('luasnip').setup(opts)
  require('luasnip.loaders.from_vscode').lazy_load({
    paths = { vim.fn.expand('$XDG_CONFIG_HOME/nvim/snippets') },
  })
end

return M
