-- ┏━┓╻ ╻┏━┓┏━┓┏━┓╻ ╻┏┓╻╺┳┓
-- ┗━┓┃ ┃┣┳┛┣┳┛┃ ┃┃ ┃┃┗┫ ┃┃
-- ┗━┛┗━┛╹┗╸╹┗╸┗━┛┗━┛╹ ╹╺┻┛
-- Surround text.

local M = {
  'kylechui/nvim-surround',
  event = 'BufReadPost',
}

M.opts = function()
  local config = require('nvim-surround.config')

  return {
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
  }
end

return M
