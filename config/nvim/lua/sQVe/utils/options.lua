-- ┏━┓┏━┓╺┳╸╻┏━┓┏┓╻┏━┓
-- ┃ ┃┣━┛ ┃ ┃┃ ┃┃┗┫┗━┓
-- ┗━┛╹   ╹ ╹┗━┛╹ ╹┗━┛

local table_contains = require('sQVe.utils.table').table_contains

local M = {}

M.get_winbar_layout = function()
  local escaped_cwd = string.gsub(vim.fn.getcwd() .. '/', '([^%w])', '%%%1')
  local file = vim.fn.expand(vim.api.nvim_eval_statusline('%f', {}).str)
  local filetype = vim.bo.filetype

  local disabled_filetypes = {
    'alpha',
    'fugitive',
    'lazy',
    'neo-tree',
    'qf',
  }

  if table_contains(disabled_filetypes, filetype) then
    return ''
  end

  -- Ensure that our file path is relative to cwd.
  file = string.gsub(file, escaped_cwd, '', 1)

  return '%=%m ' .. file
end

return M
