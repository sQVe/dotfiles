-- ┏━╸╻ ╻┏┓ ╻ ╻
-- ┃  ┗┳┛┣┻┓┃ ┃
-- ┗━╸ ╹ ┗━┛┗━┛
-- Context when cycling buffers.

local M = {
  'ghillb/cybu.nvim',
  event = 'BufRead',
}

M.opts = {
  style = {
    border = 'rounded',
    padding = '2',
    path = 'tail',
  },
}

M.config = function(_, opts)
  local map = require('sQVe.utils.vim').map
  local cybu = require('cybu')

  cybu.setup(opts)

  map('n', '<Tab>', function()
    cybu.cycle('next')
  end, { desc = 'Next buffer' })
  map('n', '<S-Tab>', function()
    cybu.cycle('prev')
  end, { desc = 'Previous buffer' })
end

return M
