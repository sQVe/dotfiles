-- ┏┳┓╻┏┓╻╻   ╻ ╻╻┏━┓┏━┓╺┳╸╺┳╸┏━╸┏━┓┏┓╻┏━┓
-- ┃┃┃┃┃┗┫┃   ┣━┫┃┣━┛┣━┫ ┃  ┃ ┣╸ ┣┳┛┃┗┫┗━┓
-- ╹ ╹╹╹ ╹╹   ╹ ╹╹╹  ╹ ╹ ╹  ╹ ┗━╸╹┗╸╹ ╹┗━┛
-- Highlight patterns.

local M = {
  'echasnovski/mini.hipatterns',
  event = 'VeryLazy',
}

M.opts = function()
  local hi = require('mini.hipatterns')

  return {
    highlighters = {
      fixme = {
        pattern = '%f[%w]()FIXME()%f[%W]',
        group = 'MiniHipatternsFixme',
      },
      hack = {
        pattern = '%f[%w]()HACK()%f[%W]',
        group = 'MiniHipatternsHack',
      },
      todo = {
        pattern = '%f[%w]()TODO()%f[%W]',
        group = 'MiniHipatternsTodo',
      },
      note = {
        pattern = '%f[%w]()NOTE()%f[%W]',
        group = 'MiniHipatternsNote',
      },
      hex_color = hi.gen_highlighter.hex_color({ priority = 2000 }),
    },
  }
end

return M
