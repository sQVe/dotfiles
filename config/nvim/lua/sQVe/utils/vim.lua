-- ╻ ╻╻┏┳┓
-- ┃┏┛┃┃┃┃
-- ┗┛ ╹╹ ╹

local M = {}

M.autocmd = function(event, opts)
  opts = opts or {}
  vim.api.nvim_create_autocmd(event, opts)
end

M.map = function(mode, lhs, rhs, opts)
  opts = vim.tbl_extend('force', { silent = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M
