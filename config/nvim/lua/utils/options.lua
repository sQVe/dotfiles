-- ┏━┓┏━┓╺┳╸╻┏━┓┏┓╻┏━┓
-- ┃ ┃┣━┛ ┃ ┃┃ ┃┃┗┫┗━┓
-- ┗━┛╹   ╹ ╹┗━┛╹ ╹┗━┛

local table_contains = require('utils.table').table_contains

local M = {}

function M.get_winbar_layout()
  local cwd = vim.fn.getcwd() .. '/'
  local file = vim.fn.expand(vim.api.nvim_eval_statusline('%f', {}).str)
  local filetype = vim.bo.filetype

  local disabled_filetypes = {
    'alpha',
    'fugitive',
    'qf',
  }

  if table_contains(disabled_filetypes, filetype) then
    return ''
  end

  -- Ensure that our file path is relative to cwd.
  file = string.gsub(file, cwd, '', 1)

  return '%=%m ' .. file
end

return M
