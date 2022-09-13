-- ┏━┓╻ ╻┏━┓┏━┓┏━┓╻ ╻┏┓╻╺┳┓
-- ┗━┓┃ ┃┣┳┛┣┳┛┃ ┃┃ ┃┃┗┫ ┃┃
-- ┗━┛┗━┛╹┗╸╹┗╸┗━┛┗━┛╹ ╹╺┻┛

return function()
  local config = require('nvim-surround.config')

  require('nvim-surround').setup({
    keymaps = { visual = 'gs' },
    surrounds = {
      ['('] = {
        add = { '(', ')' },
        find = function()
          return config.get_selection({ motion = 'a(' })
        end,
        delete = '^(. ?)().-( ?.)()$',
        change = { target = '^(. ?)().-( ?.)()$' },
      },
      ['{'] = {
        add = { '{', '}' },
        find = function()
          return config.get_selection({ motion = 'a{' })
        end,
        delete = '^(. ?)().-( ?.)()$',
        change = { target = '^(. ?)().-( ?.)()$' },
      },
      ['<'] = {
        add = { '<', '>' },
        find = function()
          return config.get_selection({ motion = 'a<' })
        end,
        delete = '^(. ?)().-( ?.)()$',
        change = { target = '^(. ?)().-( ?.)()$' },
      },
      ['['] = {
        add = { '[', ']' },
        find = function()
          return config.get_selection({ motion = 'a[' })
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
