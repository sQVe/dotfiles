--  ┏━┓┏┓╻╻┏━┓┏━┓╻ ╻┏┓╻
--  ┗━┓┃┗┫┃┣━┛┣┳┛┃ ┃┃┗┫
--  ┗━┛╹ ╹╹╹  ╹┗╸┗━┛╹ ╹
return function()
    require('sniprun').setup({
        display = { 'VirtualTextOk', 'VirtualTextErr' },
        snipruncolors = {
            SniprunVirtualTextOk = { bg = '#282828', fg = '#8ec07c' },
            SniprunVirtualTextErr = { bg = '#282828', fg = '#fb4934' },
        },
    })
end
