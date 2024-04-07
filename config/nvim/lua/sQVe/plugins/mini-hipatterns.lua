-- ┏┳┓╻┏┓╻╻   ╻ ╻╻┏━┓┏━┓╺┳╸╺┳╸┏━╸┏━┓┏┓╻┏━┓
-- ┃┃┃┃┃┗┫┃   ┣━┫┃┣━┛┣━┫ ┃  ┃ ┣╸ ┣┳┛┃┗┫┗━┓
-- ╹ ╹╹╹ ╹╹   ╹ ╹╹╹  ╹ ╹ ╹  ╹ ┗━╸╹┗╸╹ ╹┗━┛
-- Highlight patterns.

local M = {
  'echasnovski/mini.hipatterns',
  event = 'VeryLazy',
}

M.opts = function()
  return {
    highlighters = {
      done = {
        pattern = '%f[%w]()DONE()%f[%W]',
        group = 'MiniHipatternsDone',
      },
      fixme = {
        pattern = '%f[%w]()FIXME()%f[%W]',
        group = 'MiniHipatternsFixme',
      },
      hack = {
        pattern = '%f[%w]()HACK()%f[%W]',
        group = 'MiniHipatternsHack',
      },
      note = {
        pattern = '%f[%w]()NOTE()%f[%W]',
        group = 'MiniHipatternsNote',
      },
      todo = {
        pattern = '%f[%w]()TODO()%f[%W]',
        group = 'MiniHipatternsTodo',
      },
      hex_color = require('mini.hipatterns').gen_highlighter.hex_color({
        priority = 2000,
      }),
    },
  }
end

return M
