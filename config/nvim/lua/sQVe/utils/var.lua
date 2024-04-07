-- ╻ ╻┏━┓┏━┓
-- ┃┏┛┣━┫┣┳┛
-- ┗┛ ╹ ╹╹┗╸

local M = {}

M.get_global_var = function(key)
  local ok, value = pcall(vim.api.nvim_get_var, key)
  if not ok then
    return nil
  end

  return ok and value or nil
end

M.set_global_var = function(key, value)
  return pcall(vim.api.nvim_set_var, key, value)
end

M.toggle_global_var = function(key)
  return M.set_global_var(key, not M.get_global_var(key))
end

M.get_buffer_var = function(bufnr, key)
  bufnr = bufnr or 0

  local ok, value = pcall(vim.api.nvim_buf_get_var, bufnr, key)
  if not ok then
    return nil
  end

  return ok and value or nil
end

M.set_buffer_var = function(bufnr, key, value)
  bufnr = bufnr or 0

  return pcall(vim.api.nvim_buf_set_var, bufnr, key, value)
end

M.toggle_buffer_var = function(bufnr, key)
  bufnr = bufnr or 0

  return M.set_buffer_var(bufnr, key, not M.get_buffer_var(bufnr, key))
end

return M
