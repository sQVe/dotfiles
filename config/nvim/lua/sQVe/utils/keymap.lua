-- ╻┏ ┏━╸╻ ╻┏┳┓┏━┓┏━┓
-- ┣┻┓┣╸ ┗┳┛┃┃┃┣━┫┣━┛
-- ╹ ╹┗━╸ ╹ ╹ ╹╹ ╹╹

local M = {}

M.map = function(mode, lhs, rhs, opts)
  opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M
