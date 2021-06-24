--  ╻ ╻┏━┓┏┓╻╻┏━┓
--  ┃┏┛┗━┓┃┗┫┃┣━┛
--  ┗┛ ┗━┛╹ ╹╹╹
return function()
    vim.cmd([[
      let g:vsnip_snippet_dir = expand('$XDG_DATA_HOME/vsnip')
    ]])

    -- Expand or jump.
    vim.cmd([[
      imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
      smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
  ]])
end
