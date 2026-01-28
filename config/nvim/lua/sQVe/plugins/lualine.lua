-- ╻  ╻ ╻┏━┓╻  ╻┏┓╻┏━╸
-- ┃  ┃ ┃┣━┫┃  ┃┃┗┫┣╸
-- ┗━╸┗━┛╹ ╹┗━╸╹╹ ╹┗━╸
-- Statusline.

local M = {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'catppuccin/nvim' },
  lazy = false,
}

local git_root_name = function()
  local root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 or root == nil then
    return ''
  end
  return vim.fn.fnamemodify(root, ':t')
end

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
  vim.o.laststatus = vim.g.lualine_laststatus

  return {
    options = {
      component_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = { 'snacks_dashboard' },
      },
      globalstatus = vim.o.laststatus == 3,
      refresh = { statusline = 0, tabline = 0 },
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = {},
      lualine_b = { { git_root_name } },
      lualine_c = {
        { 'branch' },
      },
      lualine_x = {
        {
          'filename',
          file_status = false,
          path = 1,
        },
      },
      lualine_y = {
        { 'filetype' },
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
