--  ┏━╸┏━┓╻ ╻╻ ╻┏┓ ┏━┓╻ ╻
--  ┃╺┓┣┳┛┃ ┃┃┏┛┣┻┓┃ ┃┏╋┛
--  ┗━┛╹┗╸┗━┛┗┛ ┗━┛┗━┛╹ ╹
return function()
    vim.g.gruvbox_italic = 1
    vim.g.gruvbox_transparent_bg = 1
    vim.g.gruvbox_sign_column = 'bg0'

    vim.o.background = 'dark'
    vim.cmd('colorscheme gruvbox')

    -- BufTabLine.
    vim.cmd([[
        " BufTabLine.
        hi! BufTabLineActive guifg=#a89984 guibg=#282828 gui=NONE cterm=NONE
        hi! BufTabLineCurrent guifg=#fabd2f guibg=#3c3836 gui=NONE cterm=NONE
        hi! BufTabLineFill guifg=#282828 guibg=#282828 gui=NONE cterm=NONE
        hi! BufTabLineHidden guifg=#7c6f64 guibg=#282828 gui=NONE cterm=NONE

        " Cmp.
        hi! CmpItemAbbrDeprecated guifg=#928374 guibg=NONE gui=strikethrough cterm=NONE
        hi! link CmpItemKind GruvboxYellow
        hi! link CmpItemMenu GruvboxPurple

        " Cursor and line.
        hi! Cursor guifg=#282828 guibg=#ebdbb2 gui=NONE cterm=NONE
        hi! ColorColumn guifg=NONE guibg=#282828 gui=NONE cterm=NONE

        " Floaterm.
        hi! FloatermBorder guibg=NONE guifg=#665c54

        " Indent blankline.
        hi! IndentBlanklineChar guifg=#3c3836 gui=nocombine
        hi! IndentBlanklineContextChar guifg=#a89984 gui=nocombine

        " Lightspeed.
        hi! LightspeedGreyWash guifg=#665c54 guibg=NONE gui=NONE cterm=NONE
        hi! LightspeedLabel guifg=#8ec07c guibg=NONE gui=bold cterm=NONE
        hi! LightspeedLabelOverlapped guifg=#fe8019 guibg=NONE gui=bold cterm=NONE
        hi! LightspeedOneCharMatch guifg=#282828 guibg=#8ec07c gui=bold cterm=NONE
        hi! LightspeedShortcut guifg=#282828 guibg=#8ec07c gui=bold cterm=NONE
        hi! LightspeedShortcutOverlapped guifg=#282828 guibg=#fe8019 gui=bold cterm=NONE
        hi! link LightspeedLabelDistant GruvboxFg2
        hi! link LightspeedLabelDistantOverlapped GruvboxFg3
        hi! link LightspeedMaskedChar GruvboxPurple
        hi! link LightspeedUnlabeledMatch GruvboxYellow

        " LSP.
        hi! link LspSignatureActiveParameter GruvboxOrange
        sign define DiagnosticSignError text=■ texthl=DiagnosticSignError
        sign define DiagnosticSignHint text=■ texthl=DiagnosticSignHint
        sign define DiagnosticSignInfo text=■ texthl=DiagnosticSignInfo
        sign define DiagnosticSignWarn text=■ texthl=DiagnosticSignWarn
    ]])
end

