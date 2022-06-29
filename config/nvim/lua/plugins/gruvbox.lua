--  ┏━╸┏━┓╻ ╻╻ ╻┏┓ ┏━┓╻ ╻
--  ┃╺┓┣┳┛┃ ┃┃┏┛┣┻┓┃ ┃┏╋┛
--  ┗━┛╹┗╸┗━┛┗┛ ┗━┛┗━┛╹ ╹

return function()
  local gruvbox = require('gruvbox')
  local palette = require('gruvbox.palette')

  -- Custom colors.
  local black = '#000000'

  local sign_column_override = { bg = palette.dark0 }
  local sign_column_override_map = {
    SignColumn = sign_column_override,
  }

  local gruvbox_signs = {
    'GruvboxAquaSign',
    'GruvboxBlueSign',
    'GruvboxGreenSign',
    'GruvboxOrangeSign',
    'GruvboxPurpleSign',
    'GruvboxRedSign',
    'GruvboxYellowSign',
  }
  for _, gruvbox_sign in ipairs(gruvbox_signs) do
    sign_column_override_map[gruvbox_sign] = sign_column_override
  end

  gruvbox.setup({
    italic = false,
    overrides = vim.tbl_deep_extend('force', {
      ColorColumn = { fg = 'NONE', bg = palette.dark0 },
      Comment = { italic = 1 },
      Cursor = { fg = palette.dark0, bg = palette.light1 },
      WinBar = { fg = palette.gray },

      -- Indent blankline.
      IndentBlanklineChar = { fg = palette.dark1 },
      IndentBlanklineContextChar = { fg = palette.light4 },

      -- Leap.
      LeapMatch = { fg = black, bg = palette.bright_yellow },
      LeapLabelPrimary = { fg = black, bg = palette.bright_purple },
      LeapLabelSecondary = { fg = black, bg = palette.bright_ornage },
    }, sign_column_override_map),
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
