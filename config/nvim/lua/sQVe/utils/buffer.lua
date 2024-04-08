-- ┏┓ ╻ ╻┏━╸┏━╸┏━╸┏━┓
-- ┣┻┓┃ ┃┣╸ ┣╸ ┣╸ ┣┳┛
-- ┗━┛┗━┛╹  ╹  ┗━╸╹┗╸

local M = {}

M.get_path = function(bufnr)
  bufnr = bufnr or 0

  return vim.api.nvim_buf_get_name(bufnr)
end

M.get_option_value = function(name, bufnr)
  bufnr = bufnr or 0

  return vim.api.nvim_get_option_value(name, { buf = bufnr })
end

M.get_bufnr = function()
  return vim.api.nvim_get_current_buf()
end

M.is_saved = function(bufnr)
  return M.get_path(bufnr) ~= ''
end

M.is_valid = function(bufnr)
  bufnr = bufnr or 0

  local is_listed = M.get_option_value('buflisted', bufnr)
  local is_valid = vim.api.nvim_buf_is_valid(bufnr)

  return is_valid and is_listed
end

M.is_ignored = function(bufnr)
  bufnr = bufnr or 0

  return vim.tbl_contains(
    { 'nofile', 'nowrite' },
    M.get_option_value('buftype', bufnr)
  )
end

return M
