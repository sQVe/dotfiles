-- ┏━┓┏━╸╺┳╸┏━┓
-- ┃ ┃┃   ┃ ┃ ┃
-- ┗━┛┗━╸ ╹ ┗━┛
-- GitHub interface.

local M = {
  'pwntester/octo.nvim',
  cmd = 'Octo',
}

M.opts = {
  suppress_missing_scope = { projects_v2 = true },
  timeout = 60000,
  use_local_fs = true,
}

return M
