-- ╻ ╻╻┏┳┓
-- ┃┏┛┃┃┃┃
-- ┗┛ ╹╹ ╹

local M = {}

M.autocmd = function(event, opts)
  vim.api.nvim_create_autocmd(event, opts or {})
end

M.augroup = function(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

M.highlight = function(namespace_id, name, opts)
  vim.api.nvim_set_hl(namespace_id, name, opts or {})
end

M.map = function(mode, lhs, rhs, opts)
  vim.keymap.set(
    mode,
    lhs,
    rhs,
    vim.tbl_extend('force', { silent = true }, opts or {})
  )
end

return M
