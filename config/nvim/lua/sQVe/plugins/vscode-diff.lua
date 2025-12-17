-- ╻ ╻┏━┓┏━╸┏━┓╺┳┓┏━╸   ╺┳┓╻┏━╸┏━╸
-- ┃┏┛┗━┓┃  ┃ ┃ ┃┃┣╸ ╺━╸ ┃┃┃┣╸ ┣╸
-- ┗┛ ┗━┛┗━╸┗━┛╺┻┛┗━╸   ╺┻┛╹╹  ╹
-- VSCode-style diff viewer.

local M = {
  'esmuellert/vscode-diff.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  cmd = 'CodeDiff',
}

M.opts = {
  keymaps = {
    view = {
      quit = 'q',
      toggle_explorer = '<leader>b',
      next_hunk = ']c',
      prev_hunk = '[c',
      next_file = '<Tab>',
      prev_file = '<S-Tab>',
    },
    explorer = {
      select = '<CR>',
      hover = 'K',
      refresh = 'R',
    },
  },
}

return M
