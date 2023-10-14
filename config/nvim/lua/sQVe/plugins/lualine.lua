-- ╻  ╻ ╻┏━┓╻  ╻┏┓╻┏━╸
-- ┃  ┃ ┃┣━┫┃  ┃┃┗┫┣╸
-- ┗━╸┗━┛╹ ╹┗━╸╹╹ ╹┗━╸
-- Statusline.

local M = {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
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
      component_separators = { left = '', right = '' },
      disabled_filetypes = { statusline = { 'alpha' } },
      globalstatus = true,
      section_separators = { left = '', right = '' },
      theme = gruvbox,
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
    extensions = { 'neo-tree' },
  }
end

M.config = function(_, opts)
  require('lualine').setup(opts)

  vim.opt.showtabline = 1
end

return M
