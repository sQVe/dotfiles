-- ┏┓ ┏┓ ╻ ╻┏━╸
-- ┣┻┓┣┻┓┗┳┛┣╸
-- ┗━┛┗━┛ ╹ ┗━╸
-- Delete buffers without losing window layout.

return {
  'moll/vim-bbye',
  cmd = { 'Bdelete', 'Bwipeout' },
  keys = {
    { '<Leader>q', '<Cmd>Bdelete<CR>', desc = 'Delete buffer' },
    { '<Leader>Q', '<Cmd>Bwipeout<CR>', desc = 'Wipeout buffer' },
  },
}
