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
    '<Leader><Leader>',
    function()
      commands.go_to_buffer.callback()
    end,
    desc = 'Go to buffer',
    mode = { 'n', 'v' },
  },
  {
    'z=',
    function()
      commands.fix_spelling.callback()
    end,
    desc = 'Show spelling suggestions',
    mode = { 'n', 'v' },
  },
  {
    'ä',
    function()
      commands.find_files.callback()
    end,
    desc = 'Find files',
    mode = { 'n', 'v' },
  },
  {
    'å',
    function()
      commands.search_in_files.callback()
    end,
    desc = 'Grep',
    mode = { 'n' },
  },
  {
    'å',
    function()
      commands.search_text.callback()
    end,
    desc = 'Grep',
    mode = { 'v' },
  },
  {
    'Å',
    function()
      commands.go_to_recent_file.callback()
    end,
    desc = 'Recent files',
    mode = { 'n', 'v' },
  },
  {
    'M',
    function()
      commands.go_to_mark.callback()
    end,
    desc = 'Go to mark',
    mode = { 'n' },
  },
  {
    'S',
    function()
      commands.go_to_line.callback()
    end,
    desc = 'Go to line',
    mode = { 'n' },
  },
  {
    'ZZ',
    function()
      Snacks.bufdelete.delete()
    end,
  },
  {
    'ZX',
    function()
      Snacks.bufdelete.other()
    end,
  },
}
