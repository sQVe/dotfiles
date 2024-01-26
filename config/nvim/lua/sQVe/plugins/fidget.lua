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
  },
  progress = {
    ignore_done_already = true,
    ignore_empty_message = true,
  },
}

return M
