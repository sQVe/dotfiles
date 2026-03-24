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
        action = ':lua require("sQVe.ui.command_palette.commands").search_in_files.callback()',
      },
      {
        icon = '🎒',
        key = 'Å',
        desc = 'Recent files',
        action = ':lua require("sQVe.ui.command_palette.commands").go_to_recent_file.callback()',
      },
      {
        icon = '🔧',
        key = 'w',
        desc = 'Working changes',
        action = ':lua require("sQVe.ui.command_palette.commands").diff_working_changes.callback()',
        enabled = function()
          return require('sQVe.ui.command_palette.commands').diff_working_changes.condition()
        end,
      },
      {
        icon = '🔀',
        key = 'b',
        desc = 'Branch changes',
        action = ':lua require("sQVe.ui.command_palette.commands").git_branch_changes.callback()',
        enabled = function()
          return require('sQVe.ui.command_palette.commands').git_branch_changes.condition()
        end,
      },
      {
        icon = '✏️',
        key = 'e',
        desc = 'New buffer',
        action = ':ene | startinsert',
      },
      {
        icon = '📅',
        key = 'n',
        desc = 'Weekly note',
        action = ':lua require("sQVe.ui.command_palette.commands").open_weekly_note.callback()',
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

Knowledge comes before speech and action]],
  },
  sections = {
    { section = 'header', padding = 4 },
    { section = 'keys', gap = 1, padding = 4 },
    { section = 'startup' },
  },
  width = 48,
}
