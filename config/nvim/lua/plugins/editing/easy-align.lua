--  ┏━╸┏━┓┏━┓╻ ╻   ┏━┓╻  ╻┏━╸┏┓╻
--  ┣╸ ┣━┫┗━┓┗┳┛   ┣━┫┃  ┃┃╺┓┃┗┫
--  ┗━╸╹ ╹┗━┛ ╹    ╹ ╹┗━╸╹┗━┛╹ ╹
return function()
    vim.cmd([[
        xmap <silent> ga <Plug>(EasyAlign)
        nmap <silent> ga <Plug>(EasyAlign)
    ]])
end
