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
  require('neoscroll').setup()

  require('neoscroll.config').set_mappings({
    ['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '100' } },
    ['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '100' } },
    ['<C-b>'] = {
      'scroll',
      { '-vim.api.nvim_win_get_height(0)', 'true', '200' },
    },
    ['<C-f>'] = {
      'scroll',
      { 'vim.api.nvim_win_get_height(0)', 'true', '200' },
    },
    ['<C-y>'] = { 'scroll', { '-0.10', 'false', '50' } },
    ['<C-e>'] = { 'scroll', { '0.10', 'false', '50' } },
    ['zt'] = { 'zt', { '100' } },
    ['zz'] = { 'zz', { '100' } },
    ['zb'] = { 'zb', { '100' } },
  })
end

return M
