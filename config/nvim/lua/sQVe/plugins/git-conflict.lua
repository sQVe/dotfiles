-- ┏━╸╻╺┳╸   ┏━╸┏━┓┏┓╻┏━╸╻  ╻┏━╸╺┳╸
-- ┃╺┓┃ ┃    ┃  ┃ ┃┃┗┫┣╸ ┃  ┃┃   ┃
-- ┗━┛╹ ╹    ┗━╸┗━┛╹ ╹╹  ┗━╸╹┗━╸ ╹
-- Visualize and resolve merge conflicts.

local M = {
  'akinsho/git-conflict.nvim',
  version = '*',
  event = 'BufRead',
}

M.opts = {
  disable_diagnostics = true,
  highlights = {
    incoming = 'DiffChange',
    current = 'DiffAdd',
  },
}

return M
