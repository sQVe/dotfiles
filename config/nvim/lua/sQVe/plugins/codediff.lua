-- ┏━╸┏━┓╺┳┓┏━╸╺┳┓╻┏━╸┏━╸
-- ┃  ┃ ┃ ┃┃┣╸  ┃┃┃┣╸ ┣╸
-- ┗━╸┗━┛╺┻┛┗━╸╺┻┛╹╹  ╹
-- VSCode-style diff viewer.

local M = {
  'esmuellert/codediff.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  cmd = 'CodeDiff',
}

M.opts = {
  highlights = {
    char_brightness = 0.95,
  },
  keymaps = {
    explorer = {
      toggle_view_mode = '`',
    },
    view = {
      next_file = '<Tab>',
      prev_file = '<S-Tab>',
    },
  },
}

return M
