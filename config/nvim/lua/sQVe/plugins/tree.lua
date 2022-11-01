-- ╺┳╸┏━┓┏━╸┏━╸
--  ┃ ┣┳┛┣╸ ┣╸
--  ╹ ╹┗╸┗━╸┗━╸
-- File explorer tree.

local M = {}

M.init = function(use)
  use({

    'nvim-tree/nvim-tree.lua',
    tag = 'nightly',
    config = M.config,
  })
end

M.config = function()
  local map = require('sQVe.utils.vim').map

  require('nvim-tree').setup({
    actions = {
      open_file = {
        resize_window = false,
        window_picker = { enable = false },
      },
    },
    filters = { dotfiles = true },
    hijack_cursor = true,
    remove_keymaps = true,
    renderer = {
      highlight_git = true,
      icons = { show = { git = false } },
    },
    select_prompts = true,
    sort_by = 'case_sensitive',
    system_open = { cmd = 'mimeo', args = { '-q' } },
    trash = { cmd = 'trash' },
    view = {
      hide_root_folder = true,
      preserve_window_proportions = true,
      width = 40,

      mappings = {
        list = {
          {
            key = { '<CR>', '<Right>', 'l', '<2-LeftMouse>' },
            action = 'edit',
          },
          { key = { '<Left>', 'h' }, action = 'close_node' },
          { key = { 'cd' }, action = 'cd' },

          { key = '<C-v', action = 'vsplit' },
          { key = '<C-s', action = 'split' },
          { key = '<C-t', action = 'tabnew' },

          { key = '{', action = 'first_sibling' },
          { key = '}', action = 'last_sibling' },
          { key = '<C-k>', action = 'prev_sibling' },
          { key = '<C-j>', action = 'next_sibling' },

          { key = 'K', action = 'toggle_file_info' },
          {
            key = 'zg',
            action = 'toggle_git_ignored',
          },
          {
            key = 'zi',
            action = 'toggle_dotfiles',
          },
          { key = 'zc', action = 'toggle_custom' },

          { key = 'R', action = 'refresh' },
          { key = 'a', action = 'create' },
          { key = 'dd', action = 'remove' },
          { key = 'D', action = 'trash' },
          { key = 'r', action = 'rename' },
          { key = '<C-r>', action = 'full_rename' },
          { key = 'cc', action = 'cut' },
          { key = 'yy', action = 'copy' },
          { key = 'p', action = 'paste' },
          { key = 'yn', action = 'copy_name' },
          { key = 'yp', action = 'copy_path' },
          {
            key = 'ya',
            action = 'copy_absolute_path',
          },

          { key = '-', action = 'dir_up' },
          { key = 'i', action = 'system_open' },

          { key = '<C-f>', action = 'live_filter' },
          {
            key = '<C-F>',
            action = 'clear_live_filter',
          },
          { key = 'q', action = 'close' },
          { key = '0', action = 'collapse_all' },
          { key = '$', action = 'expand_all' },
          {
            key = '.',
            action = 'run_file_command',
          },
          { key = 'm', action = 'toggle_mark' },
          { key = 'bmv', action = 'bulk_move' },

          { key = 'g?', action = 'toggle_help' },
        },
      },
    },
    update_focused_file = {
      enable = true,
      update_root = true,
    },
  })

  -- Toggle file explorer tree.
  map('n', '<Leader>f', '<Cmd>NvimTreeToggle<CR>')
end

return M
