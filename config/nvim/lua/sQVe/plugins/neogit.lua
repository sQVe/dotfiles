-- ┏┓╻┏━╸┏━┓┏━╸╻╺┳╸
-- ┃┗┫┣╸ ┃ ┃┃╺┓┃ ┃
-- ╹ ╹┗━╸┗━┛┗━┛╹ ╹
-- General git interface.

local M = {
  'NeogitOrg/neogit',
  cmd = { 'Neogit' },
  keys = {
    {
      '<Leader>g',
      function()
        require('neogit').open()
      end,
      desc = 'Open Neogit',
    },
  },
}

M.opts = {
  disable_hint = true,
  graph_style = 'unicode',
  kind = 'replace',
  mappings = {
    popup = {
      ['?'] = false,
      ['g?'] = 'HelpPopup',
    },
  },
}

return M
