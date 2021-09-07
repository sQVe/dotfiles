--  ┏━┓┏┓╻╻┏━┓┏━┓╻ ╻┏┓╻
--  ┗━┓┃┗┫┃┣━┛┣┳┛┃ ┃┃┗┫
--  ┗━┛╹ ╹╹╹  ╹┗╸┗━┛╹ ╹
return function()
    require('sniprun').setup({
        display = {"TempFloatingWindow"},
        snipruncolors = {
            SniprunFloatingWinOk = {fg = "#fbf1c7", ctermfg = "White"},
            SniprunFloatingWinErr = {fg = "#fb4934", ctermfg = "DarkRed"}
        }
    })
end
