-- ┏━┓┏━┓╺┳╸╻ ╻
-- ┣━┛┣━┫ ┃ ┣━┫
-- ╹  ╹ ╹ ╹ ╹ ╹

local M = {}

M.get_absolute_path = function(path, cwd)
  return tostring(require('plenary.path'):new(path):make_absolute(cwd))
end

M.get_cwd = function()
  return vim.fn.getcwd()
end

M.get_directory = function(path)
  return tostring(require('plenary.path'):new(path):parent())
end

M.get_relative_path = function(path, cwd)
  return tostring(require('plenary.path'):new(path):make_relative(cwd))
end

M.normalize_path = function(path)
  local normalized_path = require('plenary.path'):new(path):normalize()

  return tostring(normalized_path:gsub(vim.fn.expand('$HOME'), '~'))
end

return M
