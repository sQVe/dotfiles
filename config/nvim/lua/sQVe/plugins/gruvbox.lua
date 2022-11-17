-- ┏━╸┏━┓╻ ╻╻ ╻┏┓ ┏━┓╻ ╻
-- ┃╺┓┣┳┛┃ ┃┃┏┛┣┻┓┃ ┃┏╋┛
-- ┗━┛╹┗╸┗━┛┗┛ ┗━┛┗━┛╹ ╹
-- Gruvbox color theme.

local M = {}

M.init = function(use)
  use({ 'npxbr/gruvbox.nvim', config = M.config })
end

M.config = function()
  local gruvbox = require('gruvbox')
  local palette = require('gruvbox.palette')

  -- Custom colors.
  local black = '#000000'
  local none = 'NONE'

  local sign_highlights = {
    'GruvboxAquaSign',
    'GruvboxBlueSign',
    'GruvboxGreenSign',
    'GruvboxOrangeSign',
    'GruvboxPurpleSign',
    'GruvboxRedSign',
    'GruvboxYellowSign',
    'SignColumn',
  }

  local sign_column_override_map = {}
  for _, sign_highlight in ipairs(sign_highlights) do
    sign_column_override_map[sign_highlight] = { bg = none }
  end

  local overrides = vim.tbl_deep_extend('force', {
    ColorColumn = { fg = none, bg = none },
    Comment = { italic = true },
    Cursor = { fg = palette.dark0, bg = palette.light1 },
    String = { italic = true },
    Todo = { italic = true },
    WinBar = { fg = palette.light2 },
    WinBarNC = { fg = palette.gray },
    ['@text.danger'] = {
      fg = palette.bright_red,
      bold = true,
    },
    ['@text.emphasis'] = { italic = true },
    ['@text.note'] = {
      fg = palette.bright_aqua,
      bold = true,
    },
    ['@text.warning'] = {
      fg = palette.bright_yellow,
      bold = true,
    },
    markdownBoldItalic = { italic = true },
    markdownItalic = { italic = true },

    -- Indent blankline.
    IndentBlanklineChar = { fg = palette.dark1 },
    IndentBlanklineContextChar = { fg = palette.light4 },

    -- Leap.
    LeapMatch = { fg = black, bg = palette.bright_yellow },
    LeapLabelPrimary = { fg = black, bg = palette.bright_purple },
    LeapLabelSecondary = { fg = black, bg = palette.bright_orange },
  }, sign_column_override_map)

  gruvbox.setup({
    italic = false,
    overrides = overrides,
  })

  -- Set diagnostic signs.
  vim.fn.sign_define(
    'DiagnosticSignError',
    { text = '■', texthl = 'DiagnosticSignError' }
  )
  vim.fn.sign_define(
    'DiagnosticSignHint',
    { text = '■', texthl = 'DiagnosticSignHint' }
  )
  vim.fn.sign_define(
    'DiagnosticSignInfo',
    { text = '■', texthl = 'DiagnosticSignInfo' }
  )
  vim.fn.sign_define(
    'DiagnosticSignWarn',
    { text = '■', texthl = 'DiagnosticSignWarn' }
  )

  vim.o.background = 'dark'
  vim.cmd([[
    " Set colorscheme.
    colorscheme gruvbox

    " Telescope.
    hi! link TelescopeBorder GruvboxYellowBold
    hi! link TelescopePromptBorder Normal
    hi! link TelescopeResultsBorder FloatBorder
    hi! link TelescopePreviewBorder FloatBorder
  ]])
end

return M
