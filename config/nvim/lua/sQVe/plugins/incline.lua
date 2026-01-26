-- ╻┏┓╻┏━╸╻  ╻┏┓╻┏━╸
-- ┃┃┗┫┃  ┃  ┃┃┗┫┣╸
-- ╹╹ ╹┗━╸┗━╸╹╹ ╹┗━╸
-- Floating winbar.

local buffer = require('sQVe.utils.buffer')
local palette = require('sQVe.plugins.catppuccin.palette')
local path = require('sQVe.utils.path')

local M = {
  'b0o/incline.nvim',
  event = 'VeryLazy',
}

M.opts = {
  window = {
    padding = 0,
    margin = {
      horizontal = 0,
      vertical = 0,
    },
  },
  render = function(args)
    if not buffer.is_saved(args.buf) then
      return
    end

    local buffer_path = buffer.get_path(args.buf)
    local filename = path.get_descriptive_name(buffer_path)

    local window_count = 0
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local bufnr = vim.api.nvim_win_get_buf(win)

      if buffer.is_valid(bufnr) and buffer.is_saved(bufnr) then
        window_count = window_count + 1
      end
    end

    local is_modified = vim.bo[args.buf].modified
    local is_focused = args.focused or window_count == 1

    local guifg
    if is_modified then
      guifg = palette.teal
    elseif is_focused then
      guifg = palette.text
    else
      guifg = palette.overlay1
    end

    local guibg
    if is_focused then
      guibg = palette.crust
    else
      guibg = palette.mantle
    end

    return {
      ' ',
      { filename, gui = 'italic' },
      ' ',
      guifg = guifg,
      guibg = guibg,
    }
  end,
}

return M
