-- ┏━┓┏━╸┏┓╻╺┳┓┏━╸┏━┓   ┏┳┓┏━┓┏━┓╻┏ ╺┳┓┏━┓╻ ╻┏┓╻
-- ┣┳┛┣╸ ┃┗┫ ┃┃┣╸ ┣┳┛   ┃┃┃┣━┫┣┳┛┣┻┓ ┃┃┃ ┃┃╻┃┃┗┫
-- ╹┗╸┗━╸╹ ╹╺┻┛┗━╸╹┗╸   ╹ ╹╹ ╹╹┗╸╹ ╹╺┻┛┗━┛┗┻┛╹ ╹
-- Stylish markdown rendering.

local M = {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown' },
}

M.opts = {
  checkbox = {
    custom = {
      skip = {
        raw = '[-]',
        rendered = '󱋭 ',
        highlight = 'RenderMarkdownUnchecked',
      },
    },
  },
  code = {
    language_border = ' ',
    language_left = '',
    language_right = '',
    left_pad = 2,
    right_pad = 2,
    sign = false,
  },
  quote = {
    repeat_linebreak = true,
  },
  overrides = {
    buftype = {
      nofile = { enabled = false },
    },
  },
}

return M
