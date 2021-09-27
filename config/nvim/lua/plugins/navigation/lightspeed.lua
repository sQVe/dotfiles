--  ╻  ╻┏━╸╻ ╻╺┳╸┏━┓┏━┓┏━╸┏━╸╺┳┓
--  ┃  ┃┃╺┓┣━┫ ┃ ┗━┓┣━┛┣╸ ┣╸  ┃┃
--  ┗━╸╹┗━┛╹ ╹ ╹ ┗━┛╹  ┗━╸┗━╸╺┻┛
return function()
    require('lightspeed').setup {
        cycle_group_bwd_key = '<S-Tab>',
        cycle_group_fwd_key = '<Tab>',
        jump_to_first_match = false
    }

    vim.cmd([[
        map , <Plug>Lightspeed_;_sx
        map ; <Plug>Lightspeed_,_sx
        map , <Plug>Lightspeed_;_ft
        map ; <Plug>Lightspeed_,_ft
    ]])
end
