-- ┏┳┓╻┏┓╻╻   ┏━┓╻
-- ┃┃┃┃┃┗┫┃   ┣━┫┃
-- ╹ ╹╹╹ ╹╹   ╹ ╹╹
-- Additional textobjects.

local find_indent_boundary = function(line_number, indent_level, direction)
  local step = direction == 'up' and -1 or 1
  local boundary_line = line_number

  for idx = line_number, (direction == 'up' and 1 or vim.fn.line('$')), step do
    local line_content = vim.fn.getline(idx)
    local line_indentation = string.match(line_content, '^%s*')
    local line_indentation_level = string.len(line_indentation)

    if indent_level == 0 then
      boundary_line = direction == 'up' and 1 or vim.fn.line('$')
      break
    end

    if line_content:len() ~= 0 and line_indentation_level < indent_level then
      break
    end

    boundary_line = idx
  end

  return boundary_line
end

local M = {
  'echasnovski/mini.ai',
  event = 'VeryLazy',
}

M.opts = function()
  local ai = require('mini.ai')

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
            line = find_indent_boundary(line_number, indentation_level, 'up'),
          },
          to = {
            col = 1,
            line = find_indent_boundary(line_number, indentation_level, 'down'),
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
