-- ╻ ╻╺┳╸╻╻  ┏━┓
-- ┃ ┃ ┃ ┃┃  ┗━┓
-- ┗━┛ ╹ ╹┗━╸┗━┛

local path = require('sQVe.utils.path')
local buffer = require('sQVe.utils.buffer')

local M = {}

local get_name_with_path = function(opts)
  return string.format(
    '%s (%s)',
    opts.name,
    path.normalize(path.get_relative(opts.path, opts.cwd))
  )
end

M.get_short_path = function(path_str)
  local parts = {}

  for part in string.gmatch(path_str, '[^/]+') do
    table.insert(parts, part)
  end

  -- If path has 4 or fewer parts, return it as is.
  if #parts <= 4 then
    return path_str
  end

  -- Keep first two and last two parts (last directory + filename)
  local shortened = {
    parts[1],
    parts[2],
    '..',
    parts[#parts - 1],
    parts[#parts],
  }

  return table.concat(shortened, '/')
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
