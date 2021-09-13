--  ┏━┓╻┏━╸┏┓╻┏━┓╺┳╸╻ ╻┏━┓┏━╸
--  ┗━┓┃┃╺┓┃┗┫┣━┫ ┃ ┃ ┃┣┳┛┣╸
--  ┗━┛╹┗━┛╹ ╹╹ ╹ ╹ ┗━┛╹┗╸┗━╸
return function()
    require('lsp_signature').on_attach({
        bind = true,
        floating_window = true,
        floating_window_above_cur_line = true,
        handler_opts = {border = "single"},
        hint_enable = false,
        zindex = 50
    })
end
