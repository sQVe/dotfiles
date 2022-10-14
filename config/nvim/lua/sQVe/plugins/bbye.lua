-- ┏┓ ┏┓ ╻ ╻┏━╸
-- ┣┻┓┣┻┓┗┳┛┣╸
-- ┗━┛┗━┛ ╹ ┗━╸
-- Delete buffers without losing window layout.

local M = {}

M.init = function(use)
  use({ 'moll/vim-bbye', cmd = { 'Bdelete', 'Bwipeout' }, setup = M.setup })
end

M.setup = function()
  local map = require('sQVe.utils.vim').map

  -- Close buffer.
  map('n', '<Leader>d', '<Cmd>Bdelete<CR>')

  -- Wipeout buffer.
  map('n', '<Leader>D', '<Cmd>Bwipeout<CR>')
end

return M
