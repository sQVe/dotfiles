local M = {}

M.init = function(use)
  use({
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    config = M.config,
    event = 'BufEnter',
  })
end

M.config = function()
  local map = require('sQVe.utils.vim').map

  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  require('neo-tree').setup({
    hide_root_node = true,
    log_level = 'warn',
    filesystem = {
      follow_current_file = false,
      hijack_netrw_behavior = 'open_current',
    },
    window = {
      mappings = {
        ['-'] = 'close_window',
        ['h'] = 'close_node',
        ['<Left>'] = 'close_node',
        ['l'] = 'open',
        ['<Right>'] = 'open',
        ['v'] = 'open_vsplit',
        ['c'] = { 'copy', config = { show_path = 'relative' } },
        ['m'] = { 'move', config = { show_path = 'relative' } },
        ['F'] = 'clear_filter',
      },
    },
  })

  -- Toggle file explorer tree.
  map('n', '-', '<Cmd>Neotree action=show toggle<CR>')
  map('n', '_', '<Cmd>Neotree action=show reveal<CR>')
end

return M
