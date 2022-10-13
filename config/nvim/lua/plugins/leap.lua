-- ╻  ┏━╸┏━┓┏━┓
-- ┃  ┣╸ ┣━┫┣━┛
-- ┗━╸┗━╸╹ ╹╹
-- Quick jump via labels.

local M = {}

M.init = function(use)
  use({ 'ggandor/leap.nvim', config = M.config, after = 'vim-repeat' })
end

M.config = function()
  local leap = require('leap')

  leap.set_default_keymaps()
  leap.setup({
    special_keys = {
      repeat_search = '<CR>',
      next_aot_match = '<CR>',
      next_match = { ',', '<CR>' },
      prev_match = { ';', '<S-CR>' },
      next_group = '<Tab>',
      prev_group = '<S-Tab>',
    },
  })
end

return M
