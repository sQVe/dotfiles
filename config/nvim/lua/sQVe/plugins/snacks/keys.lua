-- ╻┏ ┏━╸╻ ╻┏━┓
-- ┣┻┓┣╸ ┗┳┛┗━┓
-- ╹ ╹┗━╸ ╹ ┗━┛
-- Keybindings.

local commands = require('sQVe.ui.command_palette.commands')

return {
  {
    '<Backspace>',
    function()
      require('sQVe.ui.command_palette').open_command_palette()
    end,
    desc = 'Open command palette',
    mode = { 'n', 'v' },
  },
  {
    'z=',
    function()
      commands.spelling.callback()
    end,
    desc = 'Show spelling suggestions',
    mode = { 'n', 'v' },
  },
  {
    'ä',
    function()
      Snacks.picker.buf_files()
    end,
    desc = 'Find files',
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
    'Å',
    function()
      commands.recent_files.callback()
    end,
    desc = 'Recent files',
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
}
