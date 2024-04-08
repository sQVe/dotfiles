-- ╻ ╻┏━┓┏━┓
-- ┃┏┛┣━┫┣┳┛
-- ┗┛ ╹ ╹╹┗╸

local M = {}

M.get_global = function(key)
  local ok, value = pcall(vim.api.nvim_get_var, key)
  if not ok then
    return nil
  end

  return ok and value or nil
end

M.set_global = function(key, value)
  return pcall(vim.api.nvim_set_var, key, value)
end

M.toggle_global = function(key)
  return M.set_global(key, not M.get_global(key))
end

M.get_buffer = function(bufnr, key)
  bufnr = bufnr or 0

  local ok, value = pcall(vim.api.nvim_buf_get_var, bufnr, key)
  if not ok then
    return nil
  end

  return ok and value or nil
end

M.set_buffer = function(bufnr, key, value)
  bufnr = bufnr or 0

  return pcall(vim.api.nvim_buf_set_var, bufnr, key, value)
end

M.toggle_buffer = function(bufnr, key)
  bufnr = bufnr or 0

  return M.set_buffer(bufnr, key, not M.get_buffer(bufnr, key))
end

return M
