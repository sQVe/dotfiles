-- ┏━┓┏┓╻┏━┓┏━╸╻┏ ┏━┓
-- ┗━┓┃┗┫┣━┫┃  ┣┻┓┗━┓
-- ┗━┛╹ ╹╹ ╹┗━╸╹ ╹┗━┛
-- Misc small quality of life plugins.

local commands = require('sQVe.ui.command_palette.commands')
local dashboard = require('sQVe.plugins.snacks.dashboard')
local picker = require('sQVe.plugins.snacks.picker')

local BIG_FILE_THRESHOLD = 1 * 1024 * 1024 -- 1 MiB.

local M = {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    {
      '<Backspace>',
      function()
        require('sQVe.ui.command_palette').open_command_palette()
      end,
      desc = 'Open command palette',
      mode = { 'n', 'v' },
    },
    {
      'ä',
      function()
        commands.smart_find.callback()
      end,
      desc = 'Smart find',
      mode = { 'n', 'v' },
    },
    {
      'å',
      function()
        commands.grep.callback()
      end,
      desc = 'Grep',
      mode = { 'n' },
    },
    {
      'å',
      function()
        commands.grep_text.callback()
      end,
      desc = 'Grep',
      mode = { 'v' },
    },
    {
      '<Leader><Leader>',
      function()
        commands.buffers.callback()
      end,
      desc = 'Buffers',
      mode = { 'n', 'v' },
    },
    {
      'M',
      function()
        commands.marks.callback()
      end,
      desc = 'Go to mark',
      mode = { 'n' },
    },
    {
      'S',
      function()
        commands.lines.callback()
      end,
      desc = 'Go to line',
      mode = { 'n' },
    },
    {
      '<Leader>q',
      function()
        Snacks.bufdelete.delete()
      end,
    },
    {
      '<Leader>Q',
      function()
        Snacks.bufdelete.other()
      end,
    },
  },
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
