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
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash search',
    },
    {
      'S',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump({
          continue = true,
        })
      end,
      desc = 'Continue flash search',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote flash search',
    },
  },
}

M.opts = {
  modes = {
    search = { enabled = false },
    treesitter = {
      highlight = {
        backdrop = true,
      },
    },
  },
}

return M
