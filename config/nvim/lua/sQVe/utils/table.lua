-- ╺┳╸┏━┓┏┓ ╻  ┏━╸
--  ┃ ┣━┫┣┻┓┃  ┣╸
--  ╹ ╹ ╹┗━┛┗━╸┗━╸

local M = {}

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
