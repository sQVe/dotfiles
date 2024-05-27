-- ┏┳┓╻┏┓╻╻   ╺┳┓╻┏━╸┏━╸
-- ┃┃┃┃┃┗┫┃    ┃┃┃┣╸ ┣╸
-- ╹ ╹╹╹ ╹╹   ╺┻┛╹╹  ╹
-- Git diff.

local buffer = require('sQVe.utils.buffer')

local M = {
  'echasnovski/mini.diff',
  event = 'VeryLazy',
  keys = {
    { '[h', desc = 'Go to previous hunk' },
    { ']h', desc = 'Go to next hunk' },
    { 'g+', desc = 'Apply hunk' },
    { 'g-', desc = 'Reset hunk' },
    {
      'gh',
      mode = 'n',
      function()
        local bufnr = buffer.get_bufnr()

        require('mini.diff').toggle_overlay(bufnr)
      end,
      desc = 'Toggle inline diff',
    },
  },
}

M.opts = {
  mappings = {
    apply = 'g+',
    reset = 'g-',
    textobject = 'gh',
    goto_first = '',
    goto_prev = '[h',
    goto_next = ']h',
    goto_last = '',
  },
  view = { style = 'sign', priority = 0 },
}

return M
