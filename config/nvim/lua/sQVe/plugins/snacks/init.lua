-- ┏━┓┏┓╻┏━┓┏━╸╻┏ ┏━┓
-- ┗━┓┃┗┫┣━┫┃  ┣┻┓┗━┓
-- ┗━┛╹ ╹╹ ╹┗━╸╹ ╹┗━┛
-- Misc small quality of life plugins.

local dashboard = require('sQVe.plugins.snacks.dashboard')
local keys = require('sQVe.plugins.snacks.keys')
local picker = require('sQVe.plugins.snacks.picker')

local BIG_FILE_THRESHOLD = 1 * 1024 * 1024 -- 1 MiB.

local M = {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = keys,
}

M.opts = {
  bigfile = { size = BIG_FILE_THRESHOLD },
  dashboard = dashboard,
  indent = {
    indent = { only_current = true },
    animate = { enabled = false },
  },
  input = { enabled = true },
  picker = picker,
  quickfile = { enabled = true },
  scroll = {
    animate = {
      duration = { step = 5, total = 150 },
    },
    animate_repeat = {
      delay = 50,
      duration = { step = 5, total = 25 },
    },
  },
  statuscolumn = {
    left = { 'sign' },
    folds = { open = true },
  },
  styles = {
    input = {
      relative = 'cursor',
      row = 1,
    },
  },
}

return M
