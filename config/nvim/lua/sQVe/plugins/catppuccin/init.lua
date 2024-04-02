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
  compile_path = vim.fn.expand('$PERSISTENT_CACHE') .. '/catppuccin',
  color_overrides = { all = palette.gruvcat },
  custom_highlights = custom_highlights,
  default_integrations = false,
  integrations = integrations,
  styles = styles,
}

M.config = function(_, opts)
  require('catppuccin').setup(opts)

  -- Set diagnostic signs.
  for _, sign in ipairs({ 'Error', 'Hint', 'Info', 'Warn' }) do
    vim.fn.sign_define(
      'DiagnosticSign' .. sign,
      { text = '', texthl = 'DiagnosticSign' .. sign }
    )
  end

  vim.o.background = 'dark'
  vim.cmd.colorscheme('catppuccin')
end

return M
