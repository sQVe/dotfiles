-- ┏━┓┏━╸┏━╸╻┏━┓╺┳╸┏━╸┏━┓┏━┓
-- ┣┳┛┣╸ ┃╺┓┃┗━┓ ┃ ┣╸ ┣┳┛┗━┓
-- ╹┗╸┗━╸┗━┛╹┗━┛ ╹ ┗━╸╹┗╸┗━┛
-- Preview registers.

return {
  'tversteeg/registers.nvim',
  cmd = { 'Registers' },
  config = true,
  keys = {
    { '<c-r>', mode = { 'i' } },
    { '"', mode = { 'n', 'v' } },
  },
}
