-- ┏━┓┏━┓┏━┓╺┳╸
-- ┗━┓┃ ┃┣┳┛ ┃
-- ┗━┛┗━┛╹┗╸ ╹
-- Sort by line and delimiter.

local M = {
  'sQVe/sort.nvim',
  dev = true,
  opts = {
    mappings = {
      operator = 'go',
      textobject = {
        inner = 'is',
        around = 'as',
      },
      motion = {
        next_delimiter = ']o',
        prev_delimiter = '[o',
      },
    },
  },
}

return M
