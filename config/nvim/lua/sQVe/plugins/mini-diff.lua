-- ┏┳┓╻┏┓╻╻   ╺┳┓╻┏━╸┏━╸
-- ┃┃┃┃┃┗┫┃    ┃┃┃┣╸ ┣╸
-- ╹ ╹╹╹ ╹╹   ╺┻┛╹╹  ╹
-- Git diff.

local M = {
  'echasnovski/mini.diff',
  event = 'VeryLazy',
  keys = {
    {
      '<Leader>hh',
      function()
        require('mini.diff').toggle_overlay()
      end,
      desc = 'Toggle git diff',
    },
    { '<Leader>hp', desc = 'Goto previous hunk' },
    { '<Leader>hn', desc = 'Goto next hunk' },
    {
      '<Leader>hq',
      function()
        vim.fn.setqflist(require('mini.diff').export('qf'))
        vim.cmd('copen')
      end,
      desc = 'List hunks in quickfix',
    },
  },
}

M.opts = {
  mappings = {
    goto_first = '',
    goto_last = '',
    goto_prev = '<Leader>hp',
    goto_next = '<Leader>hn',
  },
  view = { style = 'sign', priority = 0 },
}

return M
