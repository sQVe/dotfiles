--  ╻ ╻┏━┓┏┓╻╻┏━┓
--  ┃┏┛┗━┓┃┗┫┃┣━┛
--  ┗┛ ┗━┛╹ ╹╹╹
return function()
    vim.cmd([[
      let g:vsnip_snippet_dir = expand('$XDG_CONFIG_HOME/nvim/snippets')
    ]])

    -- Expand or jump.
    vim.cmd([[
      imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
      smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
  ]])
end
