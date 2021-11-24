--  ┏━╸┏━┓┏┳┓┏┳┓┏━╸┏┓╻╺┳╸
--  ┃  ┃ ┃┃┃┃┃┃┃┣╸ ┃┗┫ ┃
--  ┗━╸┗━┛╹ ╹╹ ╹┗━╸╹ ╹ ╹
return function()
    require('Comment').setup({
        ignore = '^$',
        pre_hook = function(ctx)
            local utils = require('Comment.utils')

            local type = ctx.ctype == utils.ctype.line and '__default'
                or '__multiline'

            local location = nil
            if ctx.ctype == utils.ctype.block then
                location =
                    require('ts_context_commentstring.utils').get_cursor_location()
            elseif
                ctx.cmotion == utils.cmotion.v
                or ctx.cmotion == utils.cmotion.V
            then
                location =
                    require('ts_context_commentstring.utils').get_visual_start_location()
            end

            return require('ts_context_commentstring.internal').calculate_commentstring({
                key = type,
                location = location,
            })
        end,
    })
end
