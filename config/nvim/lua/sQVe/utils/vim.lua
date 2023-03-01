-- ╻ ╻╻┏┳┓
-- ┃┏┛┃┃┃┃
-- ┗┛ ╹╹ ╹

local M = {}

M.autocmd = function(event, opts)
  opts = opts or {}
  vim.api.nvim_create_autocmd(event, opts)
end

M.augroup = function(name)
  return vim.api.nvim_create_augroup(name, {})
end

M.highlight = function(namespace_id, name, opts)
  opts = opts or {}
  vim.api.nvim_set_hl(namespace_id, name, opts)
end

M.map = function(mode, lhs, rhs, opts)
  opts = vim.tbl_extend('force', { silent = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M
