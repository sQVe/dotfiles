-- ┏━┓┏━╸┏┓╻╺┳┓┏━╸┏━┓   ┏┳┓┏━┓┏━┓╻┏ ╺┳┓┏━┓╻ ╻┏┓╻
-- ┣┳┛┣╸ ┃┗┫ ┃┃┣╸ ┣┳┛   ┃┃┃┣━┫┣┳┛┣┻┓ ┃┃┃ ┃┃╻┃┃┗┫
-- ╹┗╸┗━╸╹ ╹╺┻┛┗━╸╹┗╸   ╹ ╹╹ ╹╹┗╸╹ ╹╺┻┛┗━┛┗┻┛╹ ╹
-- Stylish markdown rendering.

local M = {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = 'markdown',
}

M.opts = {
  preset = 'lazy',
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
    left_pad = 2,
    right_pad = 2,
  },
  overrides = {
    buftype = {
      nofile = { enabled = false },
    },
  },
}

return M
