-- ┏┳┓╻┏┓╻╻   ┏━┓╻ ╻┏━┓┏━┓┏━┓╻ ╻┏┓╻╺┳┓
-- ┃┃┃┃┃┗┫┃   ┗━┓┃ ┃┣┳┛┣┳┛┃ ┃┃ ┃┃┗┫ ┃┃
-- ╹ ╹╹╹ ╹╹   ┗━┛┗━┛╹┗╸╹┗╸┗━┛┗━┛╹ ╹╺┻┛
-- Surround text with pairs of characters.

local M = {
  'echasnovski/mini.surround',
  keys = {
    { 'gsa', desc = 'Add surrounding', mode = { 'n', 'v' } },
    { 'gsd', desc = 'Delete surrounding' },
    { 'gsf', desc = 'Find right surrounding' },
    { 'gsF', desc = 'Find left surrounding' },
    { 'gsh', desc = 'Highlight surrounding' },
    { 'gsr', desc = 'Replace surrounding' },
    { 'gsn', desc = 'Update `MiniSurround.config.n_lines`' },
  },
}

M.opts = {
  mappings = {
    add = 'gsa',
    delete = 'gsd',
    find = 'gsf',
    find_left = 'gsF',
    highlight = 'gsh',
    replace = 'gsr',
    update_n_lines = 'gsn',
  },
}

return M
