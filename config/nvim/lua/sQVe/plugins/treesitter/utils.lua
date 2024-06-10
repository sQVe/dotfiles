-- ╻ ╻╺┳╸╻╻  ┏━┓
-- ┃ ┃ ┃ ┃┃  ┗━┓
-- ┗━┛ ╹ ╹┗━╸┗━┛

local M = {}

M.is_filesize_larger_than = function(buf, max_filesize)
  local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))

  if ok and stats and stats.size > max_filesize then
    return true
  end

  return false
end

return M
