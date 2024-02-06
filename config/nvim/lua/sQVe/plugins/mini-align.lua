-- ┏┳┓╻┏┓╻╻   ┏━┓╻  ╻┏━╸┏┓╻
-- ┃┃┃┃┃┗┫┃   ┣━┫┃  ┃┃╺┓┃┗┫
-- ╹ ╹╹╹ ╹╹   ╹ ╹┗━╸╹┗━┛╹ ╹
-- Align text.

local M = {
  'echasnovski/mini.align',
  keys = {
    { 'ga', mode = { 'n', 'v' }, desc = 'Align' },
  },
}

M.opts = {
  mappings = {
    start = '',
    start_with_preview = 'ga',
  },
  options = {
    split_pattern = '',
    justify_side = 'left',
    merge_delimiter = '',
  },
}

return M
