-- ┏━╸┏━┓┏━┓┏━┓┏━┓╻  ┏━╸
-- ┃╺┓┣┳┛┣━┫┣━┛┣━┛┃  ┣╸
-- ┗━┛╹┗╸╹ ╹╹  ╹  ┗━╸┗━╸
-- Bookmark files to quickly navigate between them.

local buffer = require('sQVe.utils.buffer')
local path = require('sQVe.utils.path')

local M = {
  'cbochs/grapple.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = 'Grapple',
  keys = {
    {
      '<C-CR>',
      function()
        local grapple = require('grapple')

        local buffer_path = buffer.get_path()
        local basename = path.get_basename(buffer_path)
        local name =
          path.remove_extension(path.get_descriptive_name(buffer_path))

        if grapple.exists() then
          grapple.untag({ path = buffer_path })
          vim.notify(
            string.format('Untagged file %s', basename),
            vim.log.levels.INFO
          )
        else
          grapple.tag({
            name = name,
            vim.notify(
              string.format('Tagged file %s', basename),
              vim.log.levels.INFO
            ),
          })
        end
      end,
      desc = 'Grapple toggle tag',
    },
    {
      '<C-Backspace>',
      '<Cmd>Grapple toggle_tags<CR>',
      desc = 'Grapple toggle tags',
    },
    {
      '<C-1>',
      '<Cmd>Grapple select index=1<CR>',
      desc = 'Go-to tag 1',
    },
    {
      '<C-2>',
      '<Cmd>Grapple select index=2<CR>',
      desc = 'Go-to tag 2',
    },
    {
      '<C-3>',
      '<Cmd>Grapple select index=3<CR>',
      desc = 'Go-to tag 3',
    },
    {
      '<C-4>',
      '<Cmd>Grapple select index=4<CR>',
      desc = 'Go-to tag 4',
    },
    {
      '<C-5>',
      '<Cmd>Grapple select index=5<CR>',
      desc = 'Go-to tag 5',
    },
  },
}

M.opts = {
  scope = 'git_branch',
  quick_select = '1234567890',
}

return M
