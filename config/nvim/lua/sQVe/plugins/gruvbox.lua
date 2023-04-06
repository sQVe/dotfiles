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
  local float_bg = '#303030'
  local sidebar_bg = '#262626'

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
    CursorLine = { bg = float_bg },
    EndOfBuffer = { fg = colors.dark0 },
    FloatBorder = { fg = colors.dark3, bg = float_bg },
    -- NOTE: Remove this once
    -- https://github.com/ellisonleao/gruvbox.nvim/pull/231 is merged.
    LspSignatureActiveParameter = { fg = colors.bright_orange, bold = true },
    NormalFloat = { bg = float_bg },
    Pmenu = { bg = colors.dark1 },
    PmenuSel = { fg = colors.dark0, bg = colors.bright_aqua },
    Todo = { italic = true },
    WinBar = { bg = none },
    WinBarNC = { bg = none },

    -- Cyby.
    CybuFocus = { fg = colors.bright_yellow },
    CybuAdjacent = { fg = colors.gray },

    -- Indent blankline.
    IndentBlanklineChar = { fg = colors.dark1 },
    IndentBlanklineSpaceChar = { fg = colors.dark1 },
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
    NeoTreeEndOfBuffer = { fg = sidebar_bg },
    NeoTreeNormal = { bg = sidebar_bg },
    NeoTreeNormalNC = { bg = sidebar_bg },
    NeoTreeRootName = { fg = colors.gray, italic = true },
    NeoTreeTabActive = { bg = sidebar_bg },
    NeoTreeWinSeparator = { fg = colors.dark0, bg = colors.dark0 },

    -- Telescope.
    TelescopeNormal = { bg = float_bg },
    TelescopeBorder = { fg = colors.bright_yellow },
    TelescopePreviewBorder = { fg = float_bg, bg = float_bg, italic = true },
    TelescopePromptBorder = { fg = colors.dark4, bg = float_bg, bold = true },
    TelescopeResultsBorder = { fg = colors.dark4, bg = float_bg },
    TelescopeTitle = { fg = colors.bright_purple },
    TelescopePromptTitle = { fg = colors.bright_yellow },

    -- Treesitter.
    ['@text.danger'] = { fg = colors.bright_red, bold = true },
    ['@text.emphasis'] = { italic = true },
    ['@text.note'] = { fg = colors.bright_aqua, bold = true },
    ['@text.warning'] = { fg = colors.bright_yellow, bold = true },
  }, sign_column_override_map)

  return {
    italic = {
      strings = true,
      comments = true,
      operators = false,
      folds = true,
    },
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
