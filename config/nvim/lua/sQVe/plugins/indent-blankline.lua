-- ╻┏┓╻╺┳┓┏━╸┏┓╻╺┳╸   ┏┓ ╻  ┏━┓┏┓╻╻┏ ╻  ╻┏┓╻┏━╸
-- ┃┃┗┫ ┃┃┣╸ ┃┗┫ ┃    ┣┻┓┃  ┣━┫┃┗┫┣┻┓┃  ┃┃┗┫┣╸
-- ╹╹ ╹╺┻┛┗━╸╹ ╹ ╹    ┗━┛┗━╸╹ ╹╹ ╹╹ ╹┗━╸╹╹ ╹┗━╸
-- Indention guides.

local M = {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufNew', 'BufRead' },
}

M.opts = {
  buftype_exclude = { 'nofile', 'terminal' },
  char = '',
  char_highlight_list = {
    'IndentBlanklineIndent1',
    'IndentBlanklineIndent2',
  },
  filetype_exclude = { 'alpha', 'help', 'neo-tree', 'lazy' },
  show_current_context = true,
  show_current_context_start = false,
  show_first_indent_level = false,
  show_trailing_blankline_indent = false,
  space_char_highlight_list = {
    'IndentBlanklineIndent1',
    'IndentBlanklineIndent2',
  },
}

return M
