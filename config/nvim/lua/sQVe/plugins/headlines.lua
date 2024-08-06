-- ╻ ╻┏━╸┏━┓╺┳┓╻  ╻┏┓╻┏━╸┏━┓
-- ┣━┫┣╸ ┣━┫ ┃┃┃  ┃┃┗┫┣╸ ┗━┓
-- ╹ ╹┗━╸╹ ╹╺┻┛┗━╸╹╹ ╹┗━╸┗━┛
-- Add spice to markdown.

local M = {
  'lukas-reineke/headlines.nvim',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  ft = { 'markdown' },
}

M.opts = {
  markdown = {
    fat_headlines = false,
    headline_highlights = {
      'Headline1',
      'Headline2',
      'Headline3',
      'Headline4',
      'Headline5',
      'Headline6',
    },
  },
}

return {}
