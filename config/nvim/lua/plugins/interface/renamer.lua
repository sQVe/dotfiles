-- ┏━┓┏━╸┏┓╻┏━┓┏┳┓┏━╸┏━┓
-- ┣┳┛┣╸ ┃┗┫┣━┫┃┃┃┣╸ ┣┳┛
-- ╹┗╸┗━╸╹ ╹╹ ╹╹ ╹┗━╸╹┗╸
return function()
  require('renamer').setup({})

  vim.cmd([[
    nnoremap <silent> <Leader>r <CMD>lua require('renamer').rename()<CR>
  ]])
end
