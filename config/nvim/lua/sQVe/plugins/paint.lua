-- ┏━┓┏━┓╻┏┓╻╺┳╸
-- ┣━┛┣━┫┃┃┗┫ ┃
-- ╹  ╹ ╹╹╹ ╹ ╹
-- Add additional highlights.

local M = {}

M.init = function(use)
  use({
    'folke/paint.nvim',
    config = M.config,
    after = 'nvim-treesitter',
  })
end

M.config = function()
  require('paint').setup({
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
  })
end

return M
