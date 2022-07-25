--  ┏━╸┏━┓╻ ╻╻ ╻┏┓ ┏━┓╻ ╻
--  ┃╺┓┣┳┛┃ ┃┃┏┛┣┻┓┃ ┃┏╋┛
--  ┗━┛╹┗╸┗━┛┗┛ ┗━┛┗━┛╹ ╹

return function()
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
    Comment = { italic = 1 },
    Cursor = { fg = palette.dark0, bg = palette.light1 },
    WinBar = { fg = palette.light2 },
    WinBarNC = { fg = palette.gray },

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

  vim.o.background = 'dark'
  vim.cmd([[
    " Set colorscheme.
    colorscheme gruvbox

    " Set diagnostic signs.
    sign define DiagnosticSignError text=■ texthl=DiagnosticSignError
    sign define DiagnosticSignHint text=■ texthl=DiagnosticSignHint
    sign define DiagnosticSignInfo text=■ texthl=DiagnosticSignInfo
    sign define DiagnosticSignWarn text=■ texthl=DiagnosticSignWarn

    " Telescope.
    hi! link TelescopeBorder GruvboxYellowBold
    hi! link TelescopePromptBorder Normal
    hi! link TelescopeResultsBorder FloatBorder
    hi! link TelescopePreviewBorder FloatBorder
  ]])
end
