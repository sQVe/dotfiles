-- ┏━╸┏━┓╻ ╻╻ ╻┏━┓
-- ┣╸ ┃ ┃┃ ┃┃ ┃┗━┓
-- ╹  ┗━┛┗━┛┗━┛┗━┛
-- Golden ratio window resizing.

local M = {}

M.init = function(use)
  use({
    'beauwilliams/focus.nvim',
    config = M.config,
    event = 'BufEnter',
  })
end

M.config = function()
  require('focus').setup({
    excluded_filetypes = { 'fugitiveblame' },
    number = false,
    signcolumn = false,
  })
end

return M
