--  ┏━┓╻┏━╸┏┓╻┏━┓╺┳╸╻ ╻┏━┓┏━╸
--  ┗━┓┃┃╺┓┃┗┫┣━┫ ┃ ┃ ┃┣┳┛┣╸
--  ┗━┛╹┗━┛╹ ╹╹ ╹ ╹ ┗━┛╹┗╸┗━╸
return function()
    require'lsp_signature'.on_attach({
        bind = true,
        floating_window = true,
        handler_opts = {border = "single"},
        hint_enable = false
    })
end
