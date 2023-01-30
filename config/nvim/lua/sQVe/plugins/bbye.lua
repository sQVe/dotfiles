-- ┏┓ ┏┓ ╻ ╻┏━╸
-- ┣┻┓┣┻┓┗┳┛┣╸
-- ┗━┛┗━┛ ╹ ┗━╸
-- Delete buffers without losing window layout.

return {
  'moll/vim-bbye',
  cmd = { 'Bdelete', 'Bwipeout' },
  keys = {
    { '<Leader>d', '<Cmd>Bdelete<CR>', desc = 'Delete buffer' },
    { '<Leader>D', '<Cmd>Bwipeout<CR>', desc = 'Wipeout buffer' },
  },
}
