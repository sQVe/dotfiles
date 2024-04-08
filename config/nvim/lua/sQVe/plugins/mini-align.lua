-- ┏┳┓╻┏┓╻╻   ┏━┓╻  ╻┏━╸┏┓╻
-- ┃┃┃┃┃┗┫┃   ┣━┫┃  ┃┃╺┓┃┗┫
-- ╹ ╹╹╹ ╹╹   ╹ ╹┗━╸╹┗━┛╹ ╹
-- Align text.

local M = {
  'echasnovski/mini.align',
  keys = {
    { 'g=', mode = { 'n', 'v' }, desc = 'Align' },
  },
}

M.opts = {
  mappings = {
    start = '',
    start_with_preview = 'g=',
  },
  options = {
    split_pattern = '',
    justify_side = 'left',
    merge_delimiter = '',
  },
}

return M
