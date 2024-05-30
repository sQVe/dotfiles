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
    close = { n = '<Leader>q' },
    gotoLocation = { n = '<CR>' },
    historyAdd = { n = '' },
    historyOpen = { n = '<C-p>' },
    pickHistoryEntry = { n = '<CR>' },
    qflist = { n = '<C-q>' },
    refresh = { n = '<C-r>' },
    replace = { n = '<C-CR>' },
    syncLine = { n = '-' },
    syncLocations = { n = '=' },
  },
}

return M
