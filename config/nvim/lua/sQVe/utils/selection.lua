-- ┏━┓┏━╸╻  ┏━╸┏━╸╺┳╸╻┏━┓┏┓╻
-- ┗━┓┣╸ ┃  ┣╸ ┃   ┃ ┃┃ ┃┃┗┫
-- ┗━┛┗━╸┗━╸┗━╸┗━╸ ╹ ╹┗━┛╹ ╹

local M = {}

M.is_visual_mode = function()
  return vim.tbl_contains({ 'V', 'v', '\22' }, vim.fn.mode(1))
end

M.get_current_region = function()
  local from_mark, to_mark = "'<", "'>"

  local function make_position(mark)
    local position = vim.fn.getpos(mark) or {}
    return { line = position[2], column = position[3] + position[4] }
  end

  local from = make_position(from_mark)
  local to = make_position(to_mark)

  -- Swap if 'to' is before 'from'.
  if
    to.line < from.line or (to.line == from.line and to.column < from.column)
  then
    return { from = to, to = from }
  end

  return { from = from, to = to }
end

M.get_lines = function(start_row, end_row)
  return vim.api.nvim_buf_get_lines(0, start_row, end_row, true)
end

M.get_text = function(start_row, start_column, end_row, end_column)
  return vim.api.nvim_buf_get_text(
    0,
    start_row,
    start_column,
    end_row,
    end_column,
    {}
  )
end

M.get_region_text = function(region, mode)
  local from, to = region.from, region.to

  if mode == 'char' then
    local to_column_offset = vim.o.selection == 'exclusive' and 1 or 0

    return M.get_text(
      from.line - 1,
      from.column - 1,
      to.line - 1,
      to.column - to_column_offset
    )
  end

  if mode == 'line' then
    return M.get_lines(from.line - 1, to.line)
  end
end

M.get_visual_mode = function()
  local types = {
    ['V'] = 'line',
    ['v'] = 'char',
    ['\22'] = 'block',
  }

  return types[vim.fn.mode(1)]
end

return M
