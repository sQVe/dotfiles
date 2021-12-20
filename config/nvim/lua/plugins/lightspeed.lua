--  ╻  ╻┏━╸╻ ╻╺┳╸┏━┓┏━┓┏━╸┏━╸╺┳┓
--  ┃  ┃┃╺┓┣━┫ ┃ ┗━┓┣━┛┣╸ ┣╸  ┃┃
--  ┗━╸╹┗━┛╹ ╹ ╹ ┗━┛╹  ┗━╸┗━╸╺┻┛

return function()
  require('lightspeed').setup({
    cycle_group_bwd_key = '<S-Tab>',
    cycle_group_fwd_key = '<Tab>',
  })

  vim.cmd([[
    " Enable ; and , navigation for char jumping.
    map , <Plug>Lightspeed_;_sx
    map ; <Plug>Lightspeed_,_sx
    map , <Plug>Lightspeed_;_ft
    map ; <Plug>Lightspeed_,_ft
  ]])
end
