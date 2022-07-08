-- ┏━┓╻ ╻┏━┓┏━┓┏━┓╻ ╻┏┓╻╺┳┓
-- ┗━┓┃ ┃┣┳┛┣┳┛┃ ┃┃ ┃┃┗┫ ┃┃
-- ┗━┛┗━┛╹┗╸╹┗╸┗━┛┗━┛╹ ╹╺┻┛

return function()
  local get_input = require('nvim-surround.utils').get_input

  require('nvim-surround').setup({
    keymaps = { visual = 'gs' },
    delimiters = {
      pairs = {
        ['('] = { '(', ')' },
        ['<'] = { '<', '>' },
        ['['] = { '[', ']' },
        ['{'] = { '{', '}' },
        ['a'] = function()
          local head = get_input('Enter mirror pair: ')
          local tail = string.reverse(string.gsub(head, '.', {
            ['('] = ')',
            ['<'] = '>',
            ['['] = ']',
            ['{'] = '}',
          }))

          return { head, tail }
        end,
        ['f'] = function()
          return { get_input('Enter function name: ') .. '(', ')' }
        end,
        ['i'] = function()
          local head = get_input('Enter head: ')
          local tail = get_input('Enter tail: ')

          return { head, string.len(tail) > 0 and tail or head }
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
