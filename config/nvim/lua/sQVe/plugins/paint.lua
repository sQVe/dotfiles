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
      pattern = '%s+(BUG)[%s:]+',
      hl = '@text.danger',
    },
    {
      filter = {},
      pattern = '%s+(FIXME)[%s:]+',
      hl = '@text.danger',
    },
    {
      filter = {},
      pattern = '%s+(HACK)[%s:]+',
      hl = '@text.warning',
    },
    {
      filter = {},
      pattern = '%s+(NOTE)[%s:]+',
      hl = '@text.note',
    },
    {
      filter = {},
      pattern = '%s+(REMEMBER)[%s:]+',
      hl = '@text.note',
    },
    {
      filter = {},
      pattern = '%s+(TODO)[%s:]+',
      hl = '@text.warning',
    },
    {
      filter = {},
      pattern = '%s+(WARNING)[%s:]+',
      hl = '@text.warning',
    },
    {
      filter = {},
      pattern = '%s+(XXX)[%s:]+',
      hl = '@text.danger',
    },
  },
}

return M
