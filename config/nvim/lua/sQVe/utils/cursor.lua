-- ┏━╸╻ ╻┏━┓┏━┓┏━┓┏━┓
-- ┃  ┃ ┃┣┳┛┗━┓┃ ┃┣┳┛
-- ┗━╸┗━┛╹┗╸┗━┛┗━┛╹┗╸

local M = {}

M.clear_before_by_length = function(length)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))

  vim.api.nvim_buf_set_text(0, row - 1, col - length, row - 1, col, {})
  vim.api.nvim_win_set_cursor(0, { row, col - length })
end

M.get_word_before = function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local start_col = col

  while start_col > 0 and line:sub(start_col, start_col):match('[%w-_]') do
    start_col = start_col - 1
  end

  return line:sub(start_col + 1, col), row, col
end

return M
