-- ┏━╸╻  ┏━┓┏━┓╻ ╻
-- ┣╸ ┃  ┣━┫┗━┓┣━┫
-- ╹  ┗━╸╹ ╹┗━┛╹ ╹
-- Navigate code quickly with labels.

local M = {
  'folke/flash.nvim',
  keys = {
    -- stylua: ignore start
    { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash', },
    { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash treesitter', },
    { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote flash', },
    -- stylua: ignore end
  },
}

M.opts = {
  modes = {
    treesitter = {
      highlight = {
        backdrop = true,
      },
    },
  },
}

return M
