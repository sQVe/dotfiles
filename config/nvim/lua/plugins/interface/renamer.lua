-- ┏━┓┏━╸┏┓╻┏━┓┏┳┓┏━╸┏━┓
-- ┣┳┛┣╸ ┃┗┫┣━┫┃┃┃┣╸ ┣┳┛
-- ╹┗╸┗━╸╹ ╹╹ ╹╹ ╹┗━╸╹┗╸
return function()
    require('renamer').setup({show_refs = true})

    vim.cmd([[
        nnoremap <silent> <Leader>r <CMD>lua require('renamer').rename()<CR>
    ]])
end
