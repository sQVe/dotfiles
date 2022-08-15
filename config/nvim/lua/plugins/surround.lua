-- ┏━┓╻ ╻┏━┓┏━┓┏━┓╻ ╻┏┓╻╺┳┓
-- ┗━┓┃ ┃┣┳┛┣┳┛┃ ┃┃ ┃┃┗┫ ┃┃
-- ┗━┛┗━┛╹┗╸╹┗╸┗━┛┗━┛╹ ╹╺┻┛

return function()
  local get_selection = require('nvim-surround.utils').config

  require('nvim-surround').setup({
    keymaps = { visual = 'gs' },
    surrounds = {
      ['('] = {
        add = { '(', ')' },
        find = function()
          return get_selection({ textobject = '(' })
        end,
        delete = '^(. ?)().-( ?.)()$',
        change = { target = '^(. ?)().-( ?.)()$' },
      },
      ['{'] = {
        add = { '{', '}' },
        find = function()
          return get_selection({ textobject = '{' })
        end,
        delete = '^(. ?)().-( ?.)()$',
        change = { target = '^(. ?)().-( ?.)()$' },
      },
      ['<'] = {
        add = { '<', '>' },
        find = function()
          return get_selection({ textobject = '<' })
        end,
        delete = '^(. ?)().-( ?.)()$',
        change = { target = '^(. ?)().-( ?.)()$' },
      },
      ['['] = {
        add = { '[', ']' },
        find = function()
          return get_selection({ textobject = '[' })
        end,
        delete = '^(. ?)().-( ?.)()$',
        change = { target = '^(. ?)().-( ?.)()$' },
      },
    },
    aliases = {
      ['a'] = false,
      ['b'] = false,
      ['B'] = false,
      ['r'] = false,
    },
  })
end
