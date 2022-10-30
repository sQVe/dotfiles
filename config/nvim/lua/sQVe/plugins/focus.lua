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
  local autocmd = require('sQVe.utils.vim').autocmd

  require('focus').setup({
    excluded_filetypes = { 'NvimTree', 'fugitiveblame' },
    number = false,
    signcolumn = false,
  })

  -- Resize windows on VimResized.
  autocmd('VimResized', {
    group = vim.api.nvim_create_augroup('VimResized', {}),
    callback = require('focus').resize,
  })
end

return M
