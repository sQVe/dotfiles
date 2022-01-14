--  ╻  ╻┏━╸╻ ╻╺┳╸┏━┓┏━┓┏━╸┏━╸╺┳┓
--  ┃  ┃┃╺┓┣━┫ ┃ ┗━┓┣━┛┣╸ ┣╸  ┃┃
--  ┗━╸╹┗━┛╹ ╹ ╹ ┗━┛╹  ┗━╸┗━╸╺┻┛

return function()
  require('lightspeed').setup({
    special_keys = {
      next_match_group = '<Tab>',
      prev_match_group = '<S-Tab>',
    },
  })

  vim.cmd([[
    " Enable ; and , navigation for char jumping.
    map , <Plug>Lightspeed_;_sx
    map ; <Plug>Lightspeed_,_sx
    map , <Plug>Lightspeed_;_ft
    map ; <Plug>Lightspeed_,_ft
  ]])
end
