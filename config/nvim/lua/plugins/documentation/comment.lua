--  ┏━╸┏━┓┏┳┓┏┳┓┏━╸┏┓╻╺┳╸
--  ┃  ┃ ┃┃┃┃┃┃┃┣╸ ┃┗┫ ┃
--  ┗━╸┗━┛╹ ╹╹ ╹┗━╸╹ ╹ ╹
return function()
    require('Comment').setup({
        ignore = '^$',
        pre_hook = function(ctx)
            local utils = require('Comment.utils')

            if ctx.ctype == utils.ctype.line or ctx.cmotion ==
                utils.cmotion.line then
                return
                    require('ts_context_commentstring.internal').calculate_commentstring()
            end
        end,
    })
end
