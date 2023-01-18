-- ╻  ╻ ╻┏━┓╻  ╻┏┓╻┏━╸
-- ┃  ┃ ┃┣━┫┃  ┃┃┗┫┣╸
-- ┗━╸┗━┛╹ ╹┗━╸╹╹ ╹┗━╸
-- Statusline.

local M = {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
}

M.opts = function()
  local gruvbox = require('lualine.themes.gruvbox')
  local modes = {
    'command',
    'inactive',
    'insert',
    'normal',
    'replace',
    'visual',
  }

  for _, mode in pairs(modes) do
    gruvbox[mode].c.gui = 'italic'
  end

  return {
    options = {
      disabled_filetypes = { 'alpha' },
      theme = gruvbox,
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = { 'diff' },
      lualine_x = {
        {
          'diagnostics',
          sections = { 'error', 'warn' },
          symbols = { error = '', warn = '' },
        },
        'filetype',
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
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
