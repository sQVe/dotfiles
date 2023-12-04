-- ┏━╸┏━┓╻ ╻╻ ╻┏┓ ┏━┓╻ ╻
-- ┃╺┓┣┳┛┃ ┃┃┏┛┣┻┓┃ ┃┏╋┛
-- ┗━┛╹┗╸┗━┛┗┛ ┗━┛┗━┛╹ ╹
-- Gruvbox color theme.

local M = {
  'npxbr/gruvbox.nvim',
  event = 'BufEnter',
}

M.opts = function()
  local colors = require('gruvbox').palette

  -- Custom colors.
  local black = '#000000'
  local none = 'NONE'
  local float_bg = '#303030'

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
    ErrorMsg = { fg = colors.bright_red, bg = none, bold = false },
    FloatBorder = { fg = colors.dark3, bg = float_bg },
    LspSignatureActiveParameter = { fg = colors.bright_orange, bold = true },
    NormalFloat = { bg = float_bg },
    Pmenu = { bg = colors.dark1 },
    PmenuSel = { fg = colors.dark0, bg = colors.bright_aqua },
    WinBar = { bg = none },
    WinBarNC = { bg = none },

    -- Copilot.
    CopilotAnnotation = { fg = colors.gray },
    CopilotSuggestion = { fg = colors.gray },

    -- Flash.
    FlashBackdrop = { fg = colors.dark3 },
    FlashCurrent = { fg = colors.dark0, bg = colors.bright_orange },
    FlashLabel = { fg = colors.dark0, bg = colors.light0, bold = true },
    FlashMatch = { fg = colors.dark0, bg = colors.bright_yellow },

    -- Illuminate.
    IlluminatedWordRead = { underline = true },
    IlluminatedWordText = { underline = true },
    IlluminatedWordWrite = { underline = true },

    -- Indent blankline.
    IblIndent = { fg = colors.dark1 },

    -- Mini hipatterns.
    MiniHipatternsFixme = {
      bg = colors.bright_red,
      fg = colors.dark0,
      bold = true,
    },
    MiniHipatternsHack = {
      bg = colors.bright_yellow,
      fg = colors.dark0,
      bold = true,
    },
    MiniHipatternsTodo = {
      bg = colors.bright_yellow,
      fg = colors.dark0,
      bold = true,
    },
    MiniHipatternsNote = {
      bg = colors.bright_aqua,
      fg = colors.dark0,
      bold = true,
    },

    -- Telescope.
    TelescopeNormal = { bg = float_bg },
    TelescopeBorder = { fg = colors.bright_yellow },
    TelescopePreviewBorder = { fg = float_bg, bg = float_bg, italic = true },
    TelescopePromptBorder = { fg = colors.dark4, bg = float_bg, bold = true },
    TelescopeResultsBorder = { fg = colors.dark4, bg = float_bg },
    TelescopeTitle = { fg = colors.bright_purple },
    TelescopePromptTitle = { fg = colors.bright_yellow },
  }, sign_column_override_map)

  return {
    italic = {
      comments = true,
      emphasis = false,
      folds = true,
      operators = false,
      strings = true,
    },
    overrides = overrides,
  }
end

M.config = function(_, opts)
  require('gruvbox').setup(opts)

  -- Set diagnostic signs.
  vim.fn.sign_define(
    'DiagnosticSignError',
    { text = '', texthl = 'DiagnosticSignError' }
  )
  vim.fn.sign_define(
    'DiagnosticSignHint',
    { text = '', texthl = 'DiagnosticSignHint' }
  )
  vim.fn.sign_define(
    'DiagnosticSignInfo',
    { text = '', texthl = 'DiagnosticSignInfo' }
  )
  vim.fn.sign_define(
    'DiagnosticSignWarn',
    { text = '', texthl = 'DiagnosticSignWarn' }
  )

  vim.o.background = 'dark'
  vim.cmd.colorscheme('gruvbox')
end

return M
