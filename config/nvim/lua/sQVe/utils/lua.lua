-- ╻  ╻ ╻┏━┓
-- ┃  ┃ ┃┣━┫
-- ┗━╸┗━┛╹ ╹

local M = {}

M.string_starts_with = function(str, start)
  return string.sub(str, 1, #start) == start
end

M.table_contains = function(tbl, value)
  local found = false

  for _, tableValue in ipairs(tbl) do
    if tableValue == value then
      found = true
    end
  end

  return found
end

return M
