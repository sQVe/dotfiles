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
  hide_root_node = true,
  log_level = 'warn',
  filesystem = {
    follow_current_file = false,
    hijack_netrw_behavior = 'open_current',
  },
  window = {
    mappings = {
      ['-'] = 'close_window',
      ['<Left>'] = 'close_node',
      ['<Right>'] = 'open',
      ['F'] = 'clear_filter',
      ['P'] = 'toggle_preview',
      ['c'] = { 'copy', config = { show_path = 'relative' } },
      ['h'] = 'close_node',
      ['l'] = 'open',
      ['m'] = { 'move', config = { show_path = 'relative' } },
      ['s'] = 'open_split',
      ['v'] = 'open_vsplit',
      ['z'] = false,
      ['<Backspace'] = false,
      ['<'] = 'navigate_up',
      ['>'] = 'set_root',
    },
  },
}

M.config = function(_, opts)
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  require('neo-tree').setup(opts)
end

return M
