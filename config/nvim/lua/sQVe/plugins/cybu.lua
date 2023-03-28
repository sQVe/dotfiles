-- ┏━╸╻ ╻┏┓ ╻ ╻
-- ┃  ┗┳┛┣┻┓┃ ┃
-- ┗━╸ ╹ ┗━┛┗━┛
-- Context when cycling buffers.

local M = {
  'ghillb/cybu.nvim',
  event = 'BufEnter',
}

M.opts = {
  behavior = {
    mode = {
      default = {
        view = 'paging',
      },
    },
  },
  display_time = 1000,
  position = {
    anchor = 'topright',
    vertical_offset = 0,
    horizontal_offset = 1,
    max_win_height = 20,
    max_win_width = 0.75,
  },
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
