-- ┏━╸╻╺┳┓┏━╸┏━╸╺┳╸
-- ┣╸ ┃ ┃┃┃╺┓┣╸  ┃
-- ╹  ╹╺┻┛┗━┛┗━╸ ╹
-- Notifications and LSP progress.

local M = {
  'j-hui/fidget.nvim',
  event = 'BufRead',
}

M.opts = {
  notification = {
    override_vim_notify = true,
    window = { winblend = 0 },
  },
  progress = {
    ignore_done_already = true,
  },
}

return M
