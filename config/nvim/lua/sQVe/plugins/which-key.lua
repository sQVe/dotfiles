-- ╻ ╻╻ ╻╻┏━╸╻ ╻   ╻┏ ┏━╸╻ ╻
-- ┃╻┃┣━┫┃┃  ┣━┫   ┣┻┓┣╸ ┗┳┛
-- ┗┻┛╹ ╹╹┗━╸╹ ╹   ╹ ╹┗━╸ ╹
-- Keymap popup.

local M = {
  'folke/which-key.nvim',
  event = 'VeryLazy',
}

M.opts = {
  icons = {
    separator = '=',
    group = '> ',
  },
  key_labels = {
    ['<leader>'] = '<Leader>',
    ['<space>'] = '<Space>',
  },
  operators = {
    gc = 'Comment',
    gb = 'Comment',
    gq = 'Format',
    ys = 'Surround',
  },
  show_help = false,
}

M.config = function(_, opts)
  local wk = require('which-key')

  wk.setup(opts)
  wk.register({
    mode = { 'n', 'v' },
    ['<C-q>'] = { name = 'Quickfix' },
    ['<C-w>'] = { name = 'Window' },
    ['<Leader>g'] = { name = 'Git' },
    ['"'] = { name = 'Registers' },
    ['@'] = { name = 'Registers' },
    ['['] = { name = 'Previous' },
    ['\''] = { name = 'Marks' },
    [']'] = { name = 'Next' },
    ['`'] = { name = 'Marks' },
    ['go'] = { name = 'Sort' },
    ['yo'] = { name = 'Toggle settings' },
  })
end

return M