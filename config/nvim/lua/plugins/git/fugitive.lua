--  ┏━╸╻ ╻┏━╸╻╺┳╸╻╻ ╻┏━╸
--  ┣╸ ┃ ┃┃╺┓┃ ┃ ┃┃┏┛┣╸
--  ╹  ┗━┛┗━┛╹ ╹ ╹┗┛ ┗━╸
return function()
  vim.g.fugitive_pty = 0

  vim.cmd([[
    nnoremap <Leader>G <Cmd>Git<Space>
    nnoremap <silent> <Leader>gb <Cmd>Git blame<CR>
    nnoremap <silent> <Leader>gd <Cmd>Gdiffsplit<CR>
    nnoremap <silent> <Leader>gf <Cmd>Git fetch<CR>
    nnoremap <silent> <Leader>gmt <Cmd>MergetoolToggle<CR>
    nnoremap <silent> <Leader>gp <Cmd>Git push<CR>
    nnoremap <silent> <Leader>gr <Cmd>Gread<CR>
    nnoremap <silent> <Leader>gs <Cmd>vertical Git<CR>
    nnoremap <silent> <Leader>gw <Cmd>Gwrite<CR>
  ]])
end
