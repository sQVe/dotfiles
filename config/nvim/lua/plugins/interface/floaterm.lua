--  ┏━╸╻  ┏━┓┏━┓╺┳╸┏━╸┏━┓┏┳┓
--  ┣╸ ┃  ┃ ┃┣━┫ ┃ ┣╸ ┣┳┛┃┃┃
--  ╹  ┗━╸┗━┛╹ ╹ ╹ ┗━╸╹┗╸╹ ╹
return function()
    vim.g.floaterm_autoclose = 1
    vim.g.floaterm_opener = 'edit'
    vim.g.floaterm_title = ''

    vim.cmd([[
        nnoremap <silent> Ä :FloatermNew vifm .<CR>
        nnoremap <silent> Å :FloatermNew vifm<CR>
    ]])
end
