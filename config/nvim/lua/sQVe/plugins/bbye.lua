-- ┏┓ ┏┓ ╻ ╻┏━╸
-- ┣┻┓┣┻┓┗┳┛┣╸
-- ┗━┛┗━┛ ╹ ┗━╸
-- Delete buffers without losing window layout.

return {
  'moll/vim-bbye',
  cmd = { 'Bdelete', 'Bwipeout' },
  keys = {
    { '<Leader>d', '<Cmd>Bdelete<CR>' },
    { '<Leader>D', '<Cmd>Bwipeout<CR>' },
  },
}
