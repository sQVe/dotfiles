-- ╺┳┓┏━┓┏━┓╻ ╻┏┓ ┏━┓┏━┓┏━┓╺┳┓
--  ┃┃┣━┫┗━┓┣━┫┣┻┓┃ ┃┣━┫┣┳┛ ┃┃
-- ╺┻┛╹ ╹┗━┛╹ ╹┗━┛┗━┛╹ ╹╹┗╸╺┻┛
-- Launch dashboard.

return {
  preset = {
    keys = {
      {
        icon = '🗒️',
        key = 'ä',
        desc = 'Find files',
        action = ':lua require("sQVe.ui.command_palette.commands").find_files.callback()',
      },
      {
        icon = '🔍',
        key = 'å',
        desc = 'Grep',
        action = ':lua require("sQVe.ui.command_palette.commands").grep.callback()',
      },
      {
        icon = '🎒',
        key = 'Å',
        desc = 'Recent files',
        action = ':lua require("sQVe.ui.command_palette.commands").recent_files.callback()',
      },
      {
        icon = '✏️',
        key = 'e',
        desc = 'New buffer',
        action = ':ene | startinsert',
      },
      {
        icon = '⚡',
        key = '<Backspace>',
        desc = 'Command palette',
        action = ':lua require("sQVe.ui.command_palette").open_command_palette()',
      },
      {
        icon = '📎',
        key = 'p',
        desc = 'Load project',
        action = ':lua require("sQVe.ui.command_palette.commands").projects.callback()',
      },
      {
        icon = '📎',
        key = 's',
        desc = 'Restore session',
        section = 'session',
      },
      {
        icon = '💤',
        key = 'l',
        desc = 'Lazy',
        action = ':Lazy',
        enabled = package.loaded.lazy ~= nil,
      },
      { icon = '🚪', key = 'q', desc = 'Quit', action = ':qa' },
    },
    header = [[
           ▄ ▄
       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄
       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █
    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █
  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄
  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄
▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █
█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █
    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█

It is essential to know a thing first
before saying or acting upon it]],
  },
  sections = {
    { section = 'header', padding = 4 },
    { section = 'keys', gap = 1, padding = 4 },
    { section = 'startup' },
  },
  width = 48,
}
