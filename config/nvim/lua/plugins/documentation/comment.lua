--  ┏━╸┏━┓┏┳┓┏┳┓┏━╸┏┓╻╺┳╸
--  ┃  ┃ ┃┃┃┃┃┃┃┣╸ ┃┗┫ ┃
--  ┗━╸┗━┛╹ ╹╹ ╹┗━╸╹ ╹ ╹
return function()
    require('Comment').setup({
        ignore = '^$',
        pre_hook = function(ctx)
            local utils = require('Comment.utils')

            local type = ctx.ctype == utils.ctype.line and '__default' or
                             '__multiline'
            return
                require('ts_context_commentstring.internal').calculate_commentstring {
                    key = type,
                }
        end,
    })
end
