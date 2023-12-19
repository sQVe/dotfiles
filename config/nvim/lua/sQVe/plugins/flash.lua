-- ┏━╸╻  ┏━┓┏━┓╻ ╻
-- ┣╸ ┃  ┣━┫┗━┓┣━┫
-- ╹  ┗━╸╹ ╹┗━┛╹ ╹
-- Navigate code quickly with labels.

local M = {
  'folke/flash.nvim',
  event = 'VeryLazy',
  keys = {
    -- stylua: ignore start
    { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash search', },
    { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter_search() end, desc = 'Flash treesitter search', },
    { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote flash search', },
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
