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
    start = 'ga',
    start_with_preview = 'gA',
  },
  options = {
    split_pattern = '',
    justify_side = 'left',
    merge_delimiter = '',
  },
}

return M
