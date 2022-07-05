--  ╻  ╻┏━╸╻ ╻╺┳╸┏━┓┏━┓┏━╸┏━╸╺┳┓
--  ┃  ┃┃╺┓┣━┫ ┃ ┗━┓┣━┛┣╸ ┣╸  ┃┃
--  ┗━╸╹┗━┛╹ ╹ ╹ ┗━┛╹  ┗━╸┗━╸╺┻┛

return function()
  local leap = require('leap')

  leap.set_default_keymaps()
  leap.setup({
    special_keys = {
      repeat_search = '<CR>',
      next_match = '<CR>',
      prev_match = '<S-CR>',
      next_group = '<Tab>',
      prev_group = '<S-Tab>',
      eol = '<Space>',
    },
  })
end
