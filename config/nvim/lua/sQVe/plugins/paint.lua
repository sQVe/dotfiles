-- ┏━┓┏━┓╻┏┓╻╺┳╸
-- ┣━┛┣━┫┃┃┗┫ ┃
-- ╹  ╹ ╹╹╹ ╹ ╹
-- Add additional highlights.

local M = {
  'folke/paint.nvim',
  event = 'VeryLazy',
}

M.opts = {
  highlights = {
    {
      filter = { filetype = 'lua' },
      pattern = '%-%-%-%s*(@%w+)',
      hl = 'Keyword',
    },
    {
      filter = {},
      pattern = 'NOTE',
      hl = '@text.note',
    },
    {
      filter = {},
      pattern = 'TODO',
      hl = '@text.warning',
    },
    {
      filter = {},
      pattern = 'HACK',
      hl = '@text.warning',
    },
    {
      filter = {},
      pattern = 'WARNING',
      hl = '@text.warning',
    },
    {
      filter = {},
      pattern = 'FIXME',
      hl = '@text.danger',
    },
    {
      filter = {},
      pattern = 'XXX',
      hl = '@text.danger',
    },
    {
      filter = {},
      pattern = 'BUG',
      hl = '@text.danger',
    },
  },
}

return M
