-- ┏┓ ╻  ┏━┓┏┳┓┏━╸
-- ┣┻┓┃  ┣━┫┃┃┃┣╸
-- ┗━┛┗━╸╹ ╹╹ ╹┗━╸
-- Git blame.

local M = {
  'FabijanZulj/blame.nvim',
  cmd = 'BlameToggle',
}

M.opts = {
  commit_detail_view = 'vsplit',
  date_format = '%Y-%m-%d %H:%M',
}

return M
