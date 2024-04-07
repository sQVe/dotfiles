-- ┏━┓┏━┓╺┳╸╻ ╻
-- ┣━┛┣━┫ ┃ ┣━┫
-- ╹  ╹ ╹ ╹ ╹ ╹

local M = {}

M.get_absolute_path = function(path, cwd)
  return tostring(require('plenary.path'):new(path):make_absolute(cwd))
end

M.get_basename = function(path)
  return vim.fn.fnamemodify(path, ':t')
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

M.get_descriptive_name = function(path)
  local generic_filenames = {
    'README',
    'actions',
    'error',
    'index',
    'init',
    'layout',
    'package',
    'page',
    'route',
    'schemas',
    'tsconfig',
  }

  local basename = M.get_basename(path)
  local basename_without_extension = M.remove_extension(basename)

  if vim.tbl_contains(generic_filenames, basename_without_extension) then
    return string.format(
      '%s/%s',
      M.get_basename(M.get_directory(path)),
      basename
    )
  end

  return basename
end

M.normalize_path = function(path)
  local normalized_path = require('plenary.path'):new(path):normalize()

  return tostring(normalized_path:gsub(vim.fn.expand('$HOME'), '~'))
end

M.remove_extension = function(path)
  return vim.fn.fnamemodify(path, ':r')
end

return M
