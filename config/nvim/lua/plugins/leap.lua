--  ╻  ╻┏━╸╻ ╻╺┳╸┏━┓┏━┓┏━╸┏━╸╺┳┓
--  ┃  ┃┃╺┓┣━┫ ┃ ┗━┓┣━┛┣╸ ┣╸  ┃┃
--  ┗━╸╹┗━┛╹ ╹ ╹ ┗━┛╹  ┗━╸┗━╸╺┻┛

return function()
  local leap = require('leap')

  leap.set_default_keymaps()
  leap.setup({
    special_keys = {
      repeat_search = '<CR>',
      next_match = ',',
      prev_match = ';',
      next_group = '<Tab>',
      prev_group = '<S-Tab>',
      eol = '<Space>',
    },
  })
end
