-- ┏┳┓╻┏┓╻╻   ┏━┓╻
-- ┃┃┃┃┃┗┫┃   ┣━┫┃
-- ╹ ╹╹╹ ╹╹   ╹ ╹╹
-- Additional textobjects.

local M = {
  'echasnovski/mini.ai',
  event = 'VeryLazy',
}

M.opts = function()
  local utils = require('sQVe.plugins.mini-ai.utils')

  return {
    custom_textobjects = {
      i = function()
        local line_number = vim.fn.line('.')
        local line_content = vim.fn.getline('.')
        local indentation = string.match(line_content, '^%s*')
        local indentation_level = string.len(indentation)

        return {
          from = {
            col = 1,
            line = utils.find_indent_boundary(
              line_number,
              indentation_level,
              'up'
            ),
          },
          to = {
            col = 1,
            line = utils.find_indent_boundary(
              line_number,
              indentation_level,
              'down'
            ),
          },
          vis_mode = 'V',
        }
      end,
      t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
    },
    n_lines = 500,
  }
end

return M
