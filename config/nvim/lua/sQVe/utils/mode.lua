-- ┏┳┓┏━┓╺┳┓┏━╸
-- ┃┃┃┃ ┃ ┃┃┣╸
-- ╹ ╹┗━┛╺┻┛┗━╸

local M = {}

M.is_visual_mode = function()
  return vim.tbl_contains({ 'v', 'V', '\22' }, vim.fn.mode(1))
end

return M
