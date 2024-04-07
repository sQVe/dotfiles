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
      lualine_a = { 'mode' },
      lualine_b = {},
      lualine_c = {
        { 'grapple', color = { fg = palette.colors.gruvbox.gray } },
      },
      lualine_x = {
        { 'filetype', color = { fg = palette.colors.gruvbox.gray } },
      },
      lualine_y = { 'location' },
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
