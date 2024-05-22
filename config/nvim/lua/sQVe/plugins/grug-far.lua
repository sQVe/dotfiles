-- ┏━╸┏━┓╻ ╻┏━╸   ┏━╸┏━┓┏━┓
-- ┃╺┓┣┳┛┃ ┃┃╺┓   ┣╸ ┣━┫┣┳┛
-- ┗━┛╹┗╸┗━┛┗━┛   ╹  ╹ ╹╹┗╸
-- Search and replace.

local M = {
  'MagicDuck/grug-far.nvim',
  cmd = { 'GrugFar' },
}

M.opts = {
  keymaps = {
    syncLocations = { n = '=' },
    syncLine = { n = '-' },
  },
}

return M
