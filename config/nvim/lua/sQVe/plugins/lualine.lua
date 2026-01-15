-- ╻  ╻ ╻┏━┓╻  ╻┏┓╻┏━╸
-- ┃  ┃ ┃┣━┫┃  ┃┃┗┫┣╸
-- ┗━╸┗━┛╹ ╹┗━╸╹╹ ╹┗━╸
-- Statusline.

local M = {
  'nvim-lualine/lualine.nvim',
  event = 'VimEnter',
}

M.init = function()
  vim.g.lualine_laststatus = vim.o.laststatus
  if vim.fn.argc(-1) > 0 then
    -- Set an empty statusline till lualine loads.
    vim.o.statusline = ' '
  else
    -- Hide the statusline on the starter page.
    vim.o.laststatus = 0
  end
end

local git_root_name = function()
  local root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 or root == nil then
    return ''
  end
  return vim.fn.fnamemodify(root, ':t')
end

M.opts = function()
  local palette = require('sQVe.plugins.catppuccin.palette')

  return {
    options = {
      component_separators = { left = '', right = '' },
      disabled_filetypes = { statusline = { 'alpha' } },
      globalstatus = true,
      section_separators = { left = '', right = '' },
      theme = 'catppuccin',
    },
    sections = {
      lualine_a = {},
      lualine_b = { { git_root_name } },
      lualine_c = {
        { 'branch', color = { fg = palette.colors.gruvbox.gray } },
      },
      lualine_x = {
        {
          'filename',
          color = { fg = palette.colors.gruvbox.gray, gui = 'italic' },
          file_status = false,
          path = 1,
        },
      },
      lualine_y = {
        { 'filetype', color = { fg = palette.colors.gruvbox.gray } },
        { 'location' },
      },
      lualine_z = {},
    },
    tabline = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'tabs' },
    },
  }
end

M.config = function(_, opts)
  require('lualine').setup(opts)

  vim.opt.showtabline = 1
end

return M
