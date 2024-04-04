-- ┏┓╻┏━┓╺┳╸┏━╸┏┓ ┏━┓╻ ╻
-- ┃┗┫┃ ┃ ┃ ┣╸ ┣┻┓┃ ┃┏╋┛
-- ╹ ╹┗━┛ ╹ ┗━╸┗━┛┗━┛╹ ╹
-- Manage Markdown-based notes.

local M = {
  'sQVe/notebox.nvim',
  dev = false,
  keys = {
    {
      '<Leader>nd',
      function()
        require('notebox.note').new_note('daily')
      end,
      desc = 'Create new daily note',
    },
    {
      '<Leader>nn',
      function()
        require('notebox.note').new_note()
      end,
      desc = 'Create new note',
    },
    {
      '<Leader>no',
      function()
        require('notebox.note').open_note()
      end,
      desc = 'Open note in Obsidian',
    },
    { '<Leader>ns', '<Cmd>SaveNotes<CR>', desc = 'Commit and push notes' },
    {
      '<Leader>nå',
      function()
        require('notebox.telescope').live_grep_note()
      end,
      desc = 'Live grep note',
    },
    {
      '<Leader>nä',
      function()
        require('notebox.telescope').find_note()
      end,
      desc = 'Find note',
    },
  },
}

M.opts = {
  get_open_options = function()
    local Path = require('plenary.path')
    local config = require('notebox.config')
    local utils = require('notebox.utils')

    local current_buffer_path = Path:new(vim.fn.expand('%:p') or '')
    local absolute_buffer_path = current_buffer_path:absolute()
    local user_config = config.get_user_config()

    if
      current_buffer_path:is_file()
      and vim.startswith(absolute_buffer_path, user_config.root_directory)
    then
      return {
        command = 'mimeo',
        args = {
          '-q',
          'obsidian://open?file='
            .. utils.urlencode(
              current_buffer_path:make_relative(user_config.root_directory)
            ),
        },
      }
    end

    return nil
  end,
  subdirectories = {
    dailies = '5-dailies',
    new_notes = '0-inbox',
    templates = 'templates',
  },
}

return M
