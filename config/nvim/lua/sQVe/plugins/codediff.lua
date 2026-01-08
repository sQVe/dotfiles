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
  keymaps = {
    view = {
      next_file = '<Tab>',
      prev_file = '<S-Tab>',
    },
  },
}

return M
