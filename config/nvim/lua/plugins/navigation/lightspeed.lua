--  ╻  ╻┏━╸╻ ╻╺┳╸┏━┓┏━┓┏━╸┏━╸╺┳┓
--  ┃  ┃┃╺┓┣━┫ ┃ ┗━┓┣━┛┣╸ ┣╸  ┃┃
--  ┗━╸╹┗━┛╹ ╹ ╹ ┗━┛╹  ┗━╸┗━╸╺┻┛
return function()
    require('lightspeed').setup {
        cycle_group_bwd_key = '<S-Tab>',
        cycle_group_fwd_key = '<Tab>',
        jump_to_first_match = false,
    }

    vim.cmd([[
        " Reset search binding.
        map s <Plug>Lightspeed_s
        map S <Plug>Lightspeed_S

        " Enable ; and , navigation for char jumping.
        map , <Plug>Lightspeed_;_sx
        map ; <Plug>Lightspeed_,_sx
        map , <Plug>Lightspeed_;_ft
        map ; <Plug>Lightspeed_,_ft
    ]])
end
