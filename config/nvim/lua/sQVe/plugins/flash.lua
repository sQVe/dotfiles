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
    {
      'S',
      mode = { 'n', 'x' },
      function()
        require('flash').jump({
          continue = true,
        })
      end,
      desc = 'Continue flash search',
    },
  },
}

M.opts = {
  label = { after = false, before = true },
}

return M
