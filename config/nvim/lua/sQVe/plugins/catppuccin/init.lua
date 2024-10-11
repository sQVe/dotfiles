-- ┏━╸┏━┓╺┳╸┏━┓┏━┓╻ ╻┏━╸┏━╸╻┏┓╻
-- ┃  ┣━┫ ┃ ┣━┛┣━┛┃ ┃┃  ┃  ┃┃┗┫
-- ┗━╸╹ ╹ ╹ ╹  ╹  ┗━┛┗━╸┗━╸╹╹ ╹
-- Catppuccin color scheme, heavily customized with gruvbox colors.

local custom_highlights = require('sQVe.plugins.catppuccin.custom_highlights')
local integrations = require('sQVe.plugins.catppuccin.integrations')
local palette = require('sQVe.plugins.catppuccin.palette')
local styles = require('sQVe.plugins.catppuccin.styles')

local M = {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
}

M.opts = {
  compile_path = vim.fn.expand('$XDG_CACHE_HOME') .. '/catppuccin',
  color_overrides = { all = palette.gruvcat },
  custom_highlights = custom_highlights,
  default_integrations = false,
  dim_inactive = {
    enabled = true,
    shade = 'dark',
    percentage = 1.5,
  },
  integrations = integrations,
  styles = styles,
}

M.config = function(_, opts)
  require('catppuccin').setup(opts)

  vim.o.background = 'dark'
  vim.cmd.colorscheme('catppuccin')
end

return M
