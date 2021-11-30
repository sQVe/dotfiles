--  ┏━╸┏━┓╻ ╻╻ ╻┏┓ ┏━┓╻ ╻
--  ┃╺┓┣┳┛┃ ┃┃┏┛┣┻┓┃ ┃┏╋┛
--  ┗━┛╹┗╸┗━┛┗┛ ┗━┛┗━┛╹ ╹
return function()
  vim.g.gruvbox_italic = 1
  vim.g.gruvbox_sign_column = 'bg0'
  vim.g.gruvbox_transparent_bg = 1

  vim.o.background = 'dark'
  vim.cmd('colorscheme gruvbox')

  vim.cmd([[
    " Override defaults.
    hi! Cursor guifg=#282828 guibg=#ebdbb2 gui=NONE cterm=NONE
    hi! ColorColumn guifg=NONE guibg=#282828 gui=NONE cterm=NONE

    " Cmp.
    hi! CmpItemAbbrDeprecated guifg=#928374 guibg=NONE gui=strikethrough cterm=NONE
    hi! link CmpItemAbbrDefault GruvboxFg4
    hi! link CmpItemKind GruvboxYellow
    hi! link CmpItemMenu GruvboxPurple

    " Indent blankline.
    hi! IndentBlanklineChar guifg=#3c3836 gui=nocombine
    hi! IndentBlanklineContextChar guifg=#a89984 gui=nocombine

    " Lightspeed.
    hi! LightspeedGreyWash guifg=#665c54 guibg=NONE gui=NONE cterm=NONE
    hi! LightspeedLabel guifg=#8ec07c guibg=NONE gui=bold cterm=NONE
    hi! LightspeedLabelOverlapped guifg=#fb4934 guibg=NONE gui=bold cterm=NONE
    hi! LightspeedOneCharMatch guifg=#fbf1c7 guibg=NONE gui=bold cterm=NONE
    hi! LightspeedShortcut guifg=#fbf1c7 guibg=NONE gui=bold cterm=NONE
    hi! LightspeedShortcutOverlapped guifg=#fbf1c7 guibg=NONE gui=bold cterm=NONE

    hi! link LightspeedLabelDistant GruvboxFg2
    hi! link LightspeedLabelDistantOverlapped GruvboxFg3
    hi! link LightspeedMaskedChar GruvboxPurple
    hi! link LightspeedUnlabeledMatch GruvboxYellow

    " LSP.
    hi! link LspReferenceRead DiffChange
    hi! link LspReferenceText DiffChange
    hi! link LspReferenceWrite DiffChange
    hi! link LspSignatureActiveParameter GruvboxOrange

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
