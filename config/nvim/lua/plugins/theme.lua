return function()
    vim.g.gruvbox_italic = 1
    vim.g.gruvbox_transparent_bg = 1

    vim.o.background = 'dark'
    vim.cmd('colorscheme gruvbox')

    -- Columns.
    vim.cmd([[
        hi ColorColumn guifg=NONE guibg=#282828 gui=NONE cterm=NONE
        hi SignColumn guifg=NONE guibg=#282828 gui=NONE cterm=NONE
    ]])

    -- BufTabLine.
    vim.cmd([[
        hi! BufTabLineActive guifg=#a89984 guibg=#282828 gui=NONE cterm=NONE
        hi! BufTabLineCurrent guifg=#fabd2f guibg=#3c3836 gui=NONE cterm=NONE
        hi! BufTabLineFill guifg=#282828 guibg=#282828 gui=NONE cterm=NONE
        hi! BufTabLineHidden guifg=#7c6f64 guibg=#282828 gui=NONE cterm=NONE
    ]])
end
