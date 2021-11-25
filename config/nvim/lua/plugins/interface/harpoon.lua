-- ╻ ╻┏━┓┏━┓┏━┓┏━┓┏━┓┏┓╻
-- ┣━┫┣━┫┣┳┛┣━┛┃ ┃┃ ┃┃┗┫
-- ╹ ╹╹ ╹╹┗╸╹  ┗━┛┗━┛╹ ╹
return function()
  require('harpoon').setup({
    global_settings = {
      save_on_toggle = true,
    },
  })

  vim.cmd([[
    nnoremap <silent> <Backspace> :lua require('harpoon.ui').toggle_quick_menu()<CR>
    nnoremap <silent> <CR><CR> :lua require('harpoon.mark').add_file()<CR>
    nnoremap <silent> <Leader>0 :lua require('harpoon.ui').nav_file(0)<CR>
    nnoremap <silent> <Leader>1 :lua require('harpoon.ui').nav_file(1)<CR>
    nnoremap <silent> <Leader>2 :lua require('harpoon.ui').nav_file(2)<CR>
    nnoremap <silent> <Leader>3 :lua require('harpoon.ui').nav_file(3)<CR>
    nnoremap <silent> <Leader>4 :lua require('harpoon.ui').nav_file(4)<CR>
    nnoremap <silent> <Leader>5 :lua require('harpoon.ui').nav_file(5)<CR>
    nnoremap <silent> <Leader>6 :lua require('harpoon.ui').nav_file(6)<CR>
    nnoremap <silent> <Leader>7 :lua require('harpoon.ui').nav_file(7)<CR>
    nnoremap <silent> <Leader>8 :lua require('harpoon.ui').nav_file(8)<CR>
    nnoremap <silent> <Leader>9 :lua require('harpoon.ui').nav_file(9)<CR>
    nnoremap <silent> <S-Tab> :lua require('harpoon.ui').nav_prev()<CR>
    nnoremap <silent> <Tab> :lua require('harpoon.ui').nav_next()<CR>
  ]])
end
