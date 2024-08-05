-- ┏┳┓╻┏┓╻╻   ┏━┓╻
-- ┃┃┃┃┃┗┫┃   ┣━┫┃
-- ╹ ╹╹╹ ╹╹   ╹ ╹╹
-- Additional textobjects.

local utils = require('sQVe.plugins.mini-ai.utils')

local M = {
  'echasnovski/mini.ai',
  event = 'VeryLazy',
}

M.opts = function()
  local ai = require('mini.ai')

  return {
    custom_textobjects = {
      d = { '%f[%d]%d+' },
      e = {
        {
          '%u[%l%d]+%f[^%l%d]',
          '%f[%S][%l%d]+%f[^%l%d]',
          '%f[%P][%l%d]+%f[^%l%d]',
          '^[%l%d]+%f[^%l%d]',
        },
        '^().*()$',
      },
      g = function(ai_type)
        local start_line, end_line = 1, vim.fn.line('$')

        if ai_type == 'i' then
          local first_nonblank, last_nonblank =
            vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)

          if first_nonblank == 0 or last_nonblank == 0 then
            return { from = { line = start_line, col = 1 } }
          end
          start_line, end_line = first_nonblank, last_nonblank
        end

        local to_col = math.max(vim.fn.getline(end_line):len(), 1)

        return {
          from = { line = start_line, col = 1 },
          to = { line = end_line, col = to_col },
        }
      end,
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
