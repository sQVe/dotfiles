-- ╻ ╻╺┳╸╻╻  ┏━┓
-- ┃ ┃ ┃ ┃┃  ┗━┓
-- ┗━┛ ╹ ╹┗━╸┗━┛

local ignored_directory_patterns = {
  '.git',
  '.next',
  '.sst',
  '.turbo',
  '.vscode',
  'build',
  'dist',
  'node_modules',
}

local M = {}

M.ignored_directory_filter = function(item)
  if not item.file then
    return false
  end

  -- Check if the file is in a directory that matches our block list.
  for _, directory in ipairs(ignored_directory_patterns) do
    if item.file:match('/' .. directory .. '/') then
      return false
    end
  end

  return true
end

return M
