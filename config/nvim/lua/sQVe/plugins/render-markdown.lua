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
  heading = { sign = false },
  overrides = {
    buftype = {
      nofile = { enabled = false },
    },
  },
  quote = { repeat_linebreak = true },
}

return M
