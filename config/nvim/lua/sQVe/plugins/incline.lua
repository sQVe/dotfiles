-- ╻┏┓╻┏━╸╻  ╻┏┓╻┏━╸
-- ┃┃┗┫┃  ┃  ┃┃┗┫┣╸
-- ╹╹ ╹┗━╸┗━╸╹╹ ╹┗━╸
-- Floating winbar.

local buffer = require('sQVe.utils.buffer')
local colors = require('sQVe.plugins.catppuccin.palette').colors
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
    if not buffer.is_saved_buffer(args.buf) then
      return
    end

    local buffer_path = buffer.get_buffer_path(args.buf)
    local filename = path.get_descriptive_name(buffer_path)

    local window_count = 0
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local bufnr = vim.api.nvim_win_get_buf(win)

      if buffer.is_valid_buffer(bufnr) and buffer.is_saved_buffer(bufnr) then
        window_count = window_count + 1
      end
    end

    local is_modified = vim.bo[args.buf].modified
    local is_focused = args.focused or window_count == 1

    local guifg
    if is_modified then
      guifg = colors.gruvbox.bright_yellow
    elseif is_focused then
      guifg = colors.custom.lavender
    else
      guifg = colors.custom.steel
    end

    local guibg
    if is_focused then
      guibg = colors.gruvbox.dark1
    else
      guibg = colors.gruvbox.dark0_soft
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
