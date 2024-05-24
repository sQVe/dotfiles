-- ┏┳┓╻┏┓╻╻   ╺┳┓╻┏━╸┏━╸
-- ┃┃┃┃┃┗┫┃    ┃┃┃┣╸ ┣╸
-- ╹ ╹╹╹ ╹╹   ╺┻┛╹╹  ╹
-- Git diff.

local M = {
  'echasnovski/mini.diff',
  event = 'VeryLazy',
  keys = {
    { 'g+', desc = 'Apply hunk' },
    { 'g-', desc = 'Reset hunk' },
    { '[h', desc = 'Go to previous hunk' },
    { ']h', desc = 'Go to next hunk' },
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
