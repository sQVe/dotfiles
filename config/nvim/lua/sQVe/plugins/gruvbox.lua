-- ┏━╸┏━┓╻ ╻╻ ╻┏┓ ┏━┓╻ ╻
-- ┃╺┓┣┳┛┃ ┃┃┏┛┣┻┓┃ ┃┏╋┛
-- ┗━┛╹┗╸┗━┛┗┛ ┗━┛┗━┛╹ ╹
-- Gruvbox color theme.

local M = { 'npxbr/gruvbox.nvim', event = 'BufEnter' }

M.opts = function()
  local colors = require('gruvbox.palette').colors

  -- Custom colors.
  local black = '#000000'
  local none = 'NONE'

  local sign_highlights = {
    'GruvboxAquaSign',
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
    String = { italic = true },
    Todo = { italic = true },
    WinBar = { bg = none },
    WinBarNC = { bg = none },

    -- Indent blankline.
    IndentBlanklineChar = { fg = colors.dark1 },
    IndentBlanklineContextChar = { fg = colors.light4 },

    -- Leap.
    Cursor = { fg = colors.dark0, bg = colors.bright_orange, reverse = false },
    LeapMatch = { fg = black, bg = colors.bright_yellow },
    LeapLabelPrimary = { fg = black, bg = colors.bright_purple },
    LeapLabelSecondary = { fg = black, bg = colors.bright_red },

    -- Markdown.
    markdownBoldItalic = { italic = true },
    markdownItalic = { italic = true },

    -- Neotree.
    NeoTreeCursorLine = { bg = colors.dark3 },
    NeoTreeIndentMarker = { fg = colors.dark2 },
    NeoTreeNormal = { bg = colors.dark1 },
    NeoTreeNormalNC = { bg = colors.dark1 },
    NeoTreeRootName = { fg = colors.gray, italic = true },
    NeoTreeWinSeparator = { fg = colors.dark0, bg = colors.dark0 },

    -- Telescope.
    TelescopeBorder = { link = 'GruvboxYellowBold' },
    TelescopePromptBorder = { link = 'Normal' },
    TelescopePreviewBorder = { link = 'FloatBorder' },
    TelescopeResultsBorder = { link = 'FloatBorder' },

    -- Treesitter.
    ['@text.danger'] = { fg = colors.bright_red, bold = true },
    ['@text.emphasis'] = { italic = true },
    ['@text.note'] = { fg = colors.bright_aqua, bold = true },
    ['@text.warning'] = { fg = colors.bright_yellow, bold = true },
  }, sign_column_override_map)

  return {
    italic = false,
    overrides = overrides,
  }
end

M.config = function(_, opts)
  require('gruvbox').setup(opts)

  -- Set diagnostic signs.
  vim.fn.sign_define(
    'DiagnosticSignError',
    { text = '', texthl = 'DiagnosticSignError' }
  )
  vim.fn.sign_define(
    'DiagnosticSignHint',
    { text = '', texthl = 'DiagnosticSignHint' }
  )
  vim.fn.sign_define(
    'DiagnosticSignInfo',
    { text = '', texthl = 'DiagnosticSignInfo' }
  )
  vim.fn.sign_define(
    'DiagnosticSignWarn',
    { text = '', texthl = 'DiagnosticSignWarn' }
  )

  vim.o.background = 'dark'
  vim.cmd.colorscheme('gruvbox')
end

return M
