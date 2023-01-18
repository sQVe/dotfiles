-- ┏━┓┏━┓┏━┓ ┏┓┏━╸┏━╸╺┳╸
-- ┣━┛┣┳┛┃ ┃  ┃┣╸ ┃   ┃
-- ╹  ╹┗╸┗━┛┗━┛┗━╸┗━╸ ╹
-- Set pwd to root directory.

local M = {
  'ahmedkhalf/project.nvim',
  name = 'project_nvim',
  cmd = 'ProjectRoot',
}

M.opts = {
  detection_methods = { 'pattern', 'lsp' },
  manual_mode = true,
  patterns = { '.git' },
}

return M
