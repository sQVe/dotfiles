-- ╻  ┏━╸┏━┓┏━┓
-- ┃  ┣╸ ┣━┫┣━┛
-- ┗━╸┗━╸╹ ╹╹
-- Quick jump via labels.

local M = {
  'ggandor/leap.nvim',
  event = 'VeryLazy',
  dependencies = {
    { 'ggandor/flit.nvim', config = true },
  },
}

M.config = function()
  local leap = require('leap')

  leap.add_default_mappings()
  leap.opts.special_keys = {
    repeat_search = '<CR>',
    next_phase_one_target = '<CR>',
    next_target = { ',', '<CR>' },
    prev_target = { ';', '<S-CR>' },
    next_group = '<Tab>',
    prev_group = '<S-Tab>',
    multi_accept = '<CR>',
    multi_revert = '<Backspace>',
  }
end

return M
