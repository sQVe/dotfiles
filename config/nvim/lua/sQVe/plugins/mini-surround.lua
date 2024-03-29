-- ┏┳┓╻┏┓╻╻   ┏━┓╻ ╻┏━┓┏━┓┏━┓╻ ╻┏┓╻╺┳┓
-- ┃┃┃┃┃┗┫┃   ┗━┓┃ ┃┣┳┛┣┳┛┃ ┃┃ ┃┃┗┫ ┃┃
-- ╹ ╹╹╹ ╹╹   ┗━┛┗━┛╹┗╸╹┗╸┗━┛┗━┛╹ ╹╺┻┛
-- Surround text with pairs of characters.

local M = {
  'echasnovski/mini.surround',
  keys = {
    { 'gs', desc = 'Add surrounding', mode = { 'n', 'v' } },
    { 'ds', desc = 'Delete surrounding' },
    { 'cs', desc = 'Replace surrounding' },
  },
}

M.opts = {
  custom_surroundings = {
    ['('] = { output = { left = '(', right = ')' } },
    [')'] = { output = { left = '( ', right = ' )' } },
    ['<'] = { output = { left = '<', right = '>' } },
    ['>'] = { output = { left = '< ', right = ' >' } },
    ['['] = { output = { left = '[', right = ']' } },
    [']'] = { output = { left = '[ ', right = ' ]' } },
    ['{'] = { output = { left = '{', right = '}' } },
    ['}'] = { output = { left = '{ ', right = ' }' } },
  },
  mappings = {
    add = 'gs',
    delete = 'ds',
    replace = 'cs',
    find = '',
    find_left = '',
    highlight = '',
    update_n_lines = '',
  },
}

return M
