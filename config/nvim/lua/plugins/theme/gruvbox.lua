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
        hi! BufTabLineActive guifg=#a89984 guibg=#282828 gui=NONE cterm=NONE
        hi! BufTabLineCurrent guifg=#fabd2f guibg=#3c3836 gui=NONE cterm=NONE
        hi! BufTabLineFill guifg=#282828 guibg=#282828 gui=NONE cterm=NONE
        hi! BufTabLineHidden guifg=#7c6f64 guibg=#282828 gui=NONE cterm=NONE
    ]])

    -- Floaterm.
    vim.cmd([[
        hi! FloatermBorder guibg=NONE guifg=#665c54
    ]])

    -- Lightspeed.
    vim.cmd([[
        LightspeedGreyWash
        LightspeedLabelDistantOverlapped
        LightspeedLabelDistant
        LightspeedLabelOverlapped
        LightspeedLabel
        LightspeedMaskedChar
        LightspeedOneCharMatch
        LightspeedPendingChangeOpArea
        LightspeedPendingOpArea
        LightspeedShortcutOverlapped
        LightspeedShortcut
        LightspeedUnlabeledMatch
    ]])

    -- Sneak.
    vim.cmd([[
        hi! Sneak guifg=#282828 guibg=#d3869b gui=bold cterm=NONE
        hi! SneakScope guifg=#282828 guibg=#8ec07c gui=bold cterm=NONE
    ]])
end
