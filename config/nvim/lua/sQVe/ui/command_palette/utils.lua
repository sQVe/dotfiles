-- ╻ ╻╺┳╸╻╻  ┏━┓
-- ┃ ┃ ┃ ┃┃  ┗━┓
-- ┗━┛ ╹ ╹┗━╸┗━┛

local M = {}

local path = require('sQVe.utils.path')
local buffer = require('sQVe.utils.buffer')

local get_name_with_path = function(opts)
  return string.format(
    '%s (%s)',
    opts.name,
    path.normalize(path.get_relative(opts.path, opts.cwd))
  )
end

M.get_name_with_buffer_directory = function(name, opts)
  return get_name_with_path({
    name = name,
    path = path.get_parent(buffer.get_path(opts.bufnr)),
    cwd = opts.cwd,
  })
end

M.get_name_with_buffer_path = function(name, opts)
  return get_name_with_path({
    name = name,
    path = buffer.get_path(opts.bufnr),
    cwd = opts.cwd,
  })
end

M.get_name_with_git_root_path = function(name, opts)
  return get_name_with_path({
    name = name,
    path = opts.git_root,
    cwd = opts.cwd,
  })
end

return M
