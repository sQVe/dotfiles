-- ┏━╸┏━┓╺┳╸┏━┓┏━┓╻ ╻┏━╸┏━╸╻┏┓╻
-- ┃  ┣━┫ ┃ ┣━┛┣━┛┃ ┃┃  ┃  ┃┃┗┫
-- ┗━╸╹ ╹ ╹ ╹  ╹  ┗━┛┗━╸┗━╸╹╹ ╹
-- Catppuccin color scheme with muted high-contrast palette.

local custom_highlights = require('sQVe.plugins.catppuccin.custom_highlights')
local integrations = require('sQVe.plugins.catppuccin.integrations')
local palette = require('sQVe.plugins.catppuccin.palette')
local styles = require('sQVe.plugins.catppuccin.styles')

local M = {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
}
--asd

M.opts = {
  compile_path = vim.fn.expand('$XDG_CACHE_HOME') .. '/catppuccin',
  color_overrides = { latte = palette },
  custom_highlights = custom_highlights,
  default_integrations = false,
  flavour = 'latte',
  integrations = integrations,
  styles = styles,
}

M.config = function(_, opts)
  require('catppuccin').setup(opts)

  vim.o.background = 'light'
  vim.cmd.colorscheme('catppuccin')
end

return M
