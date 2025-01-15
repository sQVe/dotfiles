-- ┏━╸╻  ┏━┓┏━┓╻ ╻
-- ┣╸ ┃  ┣━┫┗━┓┣━┫
-- ╹  ┗━╸╹ ╹┗━┛╹ ╹
-- Navigate code quickly with labels.

local M = {
  'folke/flash.nvim',
  event = 'VeryLazy',
  keys = {
    {
      's',
      mode = { 'n', 'x' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash search',
    },
  },
}

M.opts = {
  label = { after = false, before = true },
}

return M
