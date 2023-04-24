-- ┏┓ ╻ ╻┏━╸╻┏━╸┏┓╻┏━┓┏━┓┏━╸
-- ┣┻┓┃ ┃┣╸ ┃┃╺┓┃┗┫┃ ┃┣┳┛┣╸
-- ┗━┛┗━┛╹  ╹┗━┛╹ ╹┗━┛╹┗╸┗━╸
-- Unlist hidden buffers that are git ignored.

local M = {
  'sQVe/bufignore.nvim',
  event = { 'BufRead', 'BufWrite' },
}

M.opts = {}

M.config = true

return M
