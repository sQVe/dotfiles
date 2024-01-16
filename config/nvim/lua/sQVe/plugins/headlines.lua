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
    fat_headlines = true,
    fat_headline_upper_string = '',
    fat_headline_lower_string = '˜',
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

return M
