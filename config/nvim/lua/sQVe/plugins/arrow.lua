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
  index_keys = '1234567890fdghjklwrtyuiopzbnm',
  leader_key = '<Backspace>',
  mappings = {
    clear_all_items = 'c',
    delete_mode = 'x',
    edit = 'e',
    open_horizontal = 's',
    open_vertical = 'v',
    quit = 'q',
    toggle = 'a',
  },
  save_key = 'git_root',
  save_path = function()
    return vim.fn.stdpath('state') .. '/arrow'
  end,
  separate_by_branch = true,
  show_icons = true,
}

return M
