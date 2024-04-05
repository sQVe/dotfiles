-- ┏━╸┏━┓┏━┓┏━┓┏━┓╻  ┏━╸
-- ┃╺┓┣┳┛┣━┫┣━┛┣━┛┃  ┣╸
-- ┗━┛╹┗╸╹ ╹╹  ╹  ┗━╸┗━╸
-- Bookmark files to quickly navigate between them.

local M = {
  'cbochs/grapple.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = 'Grapple',
  keys = {
    {
      '<Leader><CR>',
      function()
        local grapple = require('grapple')

        if grapple.exists() then
          grapple.untag({ path = vim.fn.expand('%:p') })
          vim.notify(
            string.format('Untagged file %s.', vim.fn.expand('%:t')),
            vim.log.levels.INFO
          )
        else
          local generic_filenames = { 'index', 'init', 'package' }
          local name = vim.fn.expand('%:t:r') -- Name without extension.

          if vim.tbl_contains(generic_filenames, name) then
            name = vim.fn.expand('%:p:h:t') .. '/' .. name -- Parent directory + name without extension.
          end

          grapple.tag({
            name = name,
            vim.notify(
              string.format('Tagged file %s.', vim.fn.expand('%:t')),
              vim.log.levels.INFO
            ),
          })
        end
      end,
      desc = 'Grapple toggle tag',
    },
    {
      '<Leader><Backspace>',
      '<Cmd>Grapple toggle_tags<CR>',
      desc = 'Grapple toggle tags',
    },
    {
      '<Leader>1',
      '<Cmd>Grapple select index=1<CR>',
      desc = 'Go-to tag 1',
    },
    {
      '<Leader>2',
      '<Cmd>Grapple select index=2<CR>',
      desc = 'Go-to tag 2',
    },
    {
      '<Leader>3',
      '<Cmd>Grapple select index=3<CR>',
      desc = 'Go-to tag 3',
    },
    {
      '<Leader>4',
      '<Cmd>Grapple select index=4<CR>',
      desc = 'Go-to tag 4',
    },
    {
      '<Leader>5',
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
