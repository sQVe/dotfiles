-- ┏┓╻┏━╸┏━┓╺┳╸┏━┓┏━╸┏━╸
-- ┃┗┫┣╸ ┃ ┃ ┃ ┣┳┛┣╸ ┣╸
-- ╹ ╹┗━╸┗━┛ ╹ ╹┗╸┗━╸┗━╸
-- File Tree

local M = {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v2.x',
  event = 'BufEnter',
  keys = {
    { '-', '<Cmd>Neotree action=show toggle<CR>' },
    { '_', '<Cmd>Neotree action=show reveal<CR>' },
  },
}

M.opts = {
  log_level = 'warn',
  filesystem = {
    follow_current_file = false,
    hijack_netrw_behavior = 'open_current',
  },
  window = {
    mappings = {
      ['-'] = 'close_window',
      ['<'] = 'close_all_nodes',
      ['<Backspace>'] = false,
      ['<C-s>'] = 'open_split',
      ['<C-t>'] = 'open_tabnew',
      ['<C-v>'] = 'open_vsplit',
      ['<Left>'] = 'close_node',
      ['<Right>'] = 'open',
      ['>'] = 'expand_all_nodes',
      ['F'] = 'clear_filter',
      ['P'] = 'toggle_preview',
      ['S'] = false,
      ['c'] = { 'copy', config = { show_path = 'relative' } },
      ['h'] = 'close_node',
      ['l'] = 'open',
      ['m'] = { 'move', config = { show_path = 'relative' } },
      ['s'] = false,
      ['t'] = false,
      ['u'] = 'navigate_up',
      ['z'] = false,
    },
  },
}

M.config = function(_, opts)
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  require('neo-tree').setup(opts)
end

return M
