-- ┏━┓╻ ╻┏━┓┏━┓┏━┓╻ ╻┏┓╻╺┳┓
-- ┗━┓┃ ┃┣┳┛┣┳┛┃ ┃┃ ┃┃┗┫ ┃┃
-- ┗━┛┗━┛╹┗╸╹┗╸┗━┛┗━┛╹ ╹╺┻┛

return function()
  local get_input = require('nvim-surround.utils').get_input

  require('nvim-surround').setup({
    keymaps = {
      visual = 'gs',
    },
    delimiters = {
      pairs = {
        ['('] = { '(', ')' },
        [')'] = { '( ', ' )' },
        ['{'] = { '{', '}' },
        ['}'] = { '{ ', ' }' },
        ['<'] = { '<', '>' },
        ['>'] = { '< ', ' >' },
        ['['] = { '[', ']' },
        [']'] = { '[ ', ' ]' },
        ['f'] = function()
          return { get_input('Enter function name: ') .. '(', ')' }
        end,
        ['i'] = function()
          return { get_input('Enter head: '), get_input('Enter tail: ') }
        end,
      },
      aliases = {
        ['a'] = false,
        ['b'] = false,
        ['B'] = false,
        ['r'] = false,
      },
    },
  })
end
