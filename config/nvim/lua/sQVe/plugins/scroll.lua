-- ┏━╸┏━┓╻ ╻╻ ╻┏━┓
-- ┣╸ ┃ ┃┃ ┃┃ ┃┗━┓
-- ╹  ┗━┛┗━┛┗━┛┗━┛
-- Golden ratio window resizing.

local M = {}

M.init = function(use)
  use({
    'karb94/neoscroll.nvim',
    config = M.config,
    event = 'WinScrolled',
  })
end

M.config = function()
  require('neoscroll').setup({
    respect_scrolloff = true,
  })

  require('neoscroll.config').set_mappings({
    ['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '100', nil } },
    ['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '100', nil } },
    ['<C-b>'] = {
      'scroll',
      { '-vim.api.nvim_win_get_height(0)', 'true', '200', nil },
    },
    ['<C-f>'] = {
      'scroll',
      { 'vim.api.nvim_win_get_height(0)', 'true', '200', nil },
    },
    ['<C-y>'] = { 'scroll', { '-0.10', 'false', '50', nil } },
    ['<C-e>'] = { 'scroll', { '0.10', 'false', '50', nil } },
  })
end

return M
