-- ┏┓ ╻ ╻┏━╸┏━╸┏━╸┏━┓
-- ┣┻┓┃ ┃┣╸ ┣╸ ┣╸ ┣┳┛
-- ┗━┛┗━┛╹  ╹  ┗━╸╹┗╸

local M = {}

M.get_buffer_path = function(bufnr)
  bufnr = bufnr or 0

  return vim.api.nvim_buf_get_name(bufnr)
end

M.get_buffer_option_value = function(name, bufnr)
  bufnr = bufnr or 0

  return vim.api.nvim_get_option_value(name, { buf = bufnr })
end

M.is_saved_buffer = function(bufnr)
  return M.get_buffer_path(bufnr) ~= ''
end

M.is_valid_buffer = function(bufnr)
  bufnr = bufnr or 0

  local is_listed = M.get_buffer_option_value('buflisted', bufnr)
  local is_valid = vim.api.nvim_buf_is_valid(bufnr)

  return is_valid and is_listed
end

M.is_ignored_buffer = function(bufnr)
  bufnr = bufnr or 0

  return vim.tbl_contains(
    { 'nofile', 'nowrite' },
    M.get_buffer_option_value('buftype', bufnr)
  )
end

return M
