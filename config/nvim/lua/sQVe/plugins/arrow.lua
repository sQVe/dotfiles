-- ┏━┓┏━┓┏━┓┏━┓╻ ╻
-- ┣━┫┣┳┛┣┳┛┃ ┃┃╻┃
-- ╹ ╹╹┗╸╹┗╸┗━┛┗┻┛
-- Bookmark files to quickly navigate between them.

local M = {
  'otavioschwanck/arrow.nvim',
  keys = {
    { '<Backspace>', desc = 'Open arrow menu' },
    {
      '<Tab>',
      function()
        require('arrow.persist').next()
      end,
      desc = 'Go to next arrow file',
    },
    {
      '<S-Tab>',
      function()
        require('arrow.persist').previous()
      end,
      desc = 'Go to next arrow file',
    },
  },
}

M.opts = {
  index_keys = 'afghjklwrtyuiopzcbnm1234567890',
  leader_key = '<Backspace>',
  mappings = {
    edit = 'e',
    delete_mode = 'd',
    clear_all_items = 'C',
    toggle = ' ',
    open_vertical = 'v',
    open_horizontal = 's',
    quit = 'q',
  },
  save_key = 'git_root',
  save_path = function()
    return vim.fn.stdpath('state') .. '/arrow'
  end,
  separate_by_branch = true,
  show_icons = true,
}

return M
