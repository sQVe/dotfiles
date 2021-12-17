-- ╻ ╻┏━┓┏━┓┏━┓┏━┓┏━┓┏┓╻
-- ┣━┫┣━┫┣┳┛┣━┛┃ ┃┃ ┃┃┗┫
-- ╹ ╹╹ ╹╹┗╸╹  ┗━┛┗━┛╹ ╹

return function()
  require('harpoon').setup({
    global_settings = {
      save_on_toggle = true,
    },
    menu = {
      height = 20,
      width = 80,
    },
  })

  vim.cmd([[
    nnoremap <silent> <Backspace> <Cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>
    nnoremap <silent> <Leader>m <Cmd>lua require('harpoon.mark').add_file()<CR>
    nnoremap <silent> <Leader>0 <Cmd>lua require('harpoon.ui').nav_file(0)<CR>
    nnoremap <silent> <Leader>1 <Cmd>lua require('harpoon.ui').nav_file(1)<CR>
    nnoremap <silent> <Leader>2 <Cmd>lua require('harpoon.ui').nav_file(2)<CR>
    nnoremap <silent> <Leader>3 <Cmd>lua require('harpoon.ui').nav_file(3)<CR>
    nnoremap <silent> <Leader>4 <Cmd>lua require('harpoon.ui').nav_file(4)<CR>
    nnoremap <silent> <Leader>5 <Cmd>lua require('harpoon.ui').nav_file(5)<CR>
    nnoremap <silent> <Leader>6 <Cmd>lua require('harpoon.ui').nav_file(6)<CR>
    nnoremap <silent> <Leader>7 <Cmd>lua require('harpoon.ui').nav_file(7)<CR>
    nnoremap <silent> <Leader>8 <Cmd>lua require('harpoon.ui').nav_file(8)<CR>
    nnoremap <silent> <Leader>9 <Cmd>lua require('harpoon.ui').nav_file(9)<CR>
    nnoremap <silent> <S-Tab> <Cmd>lua require('harpoon.ui').nav_prev()<CR>
    nnoremap <silent> <Tab> <Cmd>lua require('harpoon.ui').nav_next()<CR>
  ]])
end
