-- ┏━╸╻╺┳┓┏━╸┏━╸╺┳╸
-- ┣╸ ┃ ┃┃┃╺┓┣╸  ┃
-- ╹  ╹╺┻┛┗━┛┗━╸ ╹
-- LSP progress.

local M = {
  'j-hui/fidget.nvim',
  ft = require('sQVe.plugins.lspconfig').ft,
}

M.opts = {
  text = { spinner = 'dots' },
  timer = { fidget_decay = 1000, task_decay = 500 },
  window = { blend = 50 },
}

return M
