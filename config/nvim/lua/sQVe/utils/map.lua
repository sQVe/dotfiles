-- ┏┳┓┏━┓┏━┓
-- ┃┃┃┣━┫┣━┛
-- ╹ ╹╹ ╹╹

local defaults = { silent = true }

return function(mode, lhs, rhs, opts)
  opts = opts or {}

  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', defaults, opts))
end
