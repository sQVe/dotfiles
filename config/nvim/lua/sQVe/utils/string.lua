-- ┏━┓╺┳╸┏━┓╻┏┓╻┏━╸
-- ┗━┓ ┃ ┣┳┛┃┃┗┫┃╺┓
-- ┗━┛ ╹ ╹┗╸╹╹ ╹┗━┛

local M = {}

M.starts_with = function(str, start)
  return string.sub(str, 1, #start) == start
end

return M
