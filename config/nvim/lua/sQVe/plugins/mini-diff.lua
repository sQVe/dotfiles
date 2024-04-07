-- ┏┳┓╻┏┓╻╻   ╺┳┓╻┏━╸┏━╸
-- ┃┃┃┃┃┗┫┃    ┃┃┃┣╸ ┣╸
-- ╹ ╹╹╹ ╹╹   ╺┻┛╹╹  ╹
-- Git diff.

local M = {
  'echasnovski/mini.diff',
  event = 'VeryLazy',
  keys = {
    { '[h', desc = 'Go to previous hunk' },
    { ']h', desc = 'Goto next hunk' },
  },
}

M.opts = {
  mappings = {
    goto_first = '',
    goto_last = '',
  },
  view = { style = 'sign', priority = 0 },
}

return M
