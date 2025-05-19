-- ┏━╸╻╺┳╸┏━┓╻┏━╸┏┓╻┏━┓
-- ┃╺┓┃ ┃ ┗━┓┃┃╺┓┃┗┫┗━┓
-- ┗━┛╹ ╹ ┗━┛╹┗━┛╹ ╹┗━┛
-- Git diff and signs.

local map = require('sQVe.utils.map')

local signs = {
  solid = '│',
  dashed = '┊',
}

local M = {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
}

M.opts = {
  attach_to_untracked = true,
  diff_opts = { ignore_whitespace = true },
  signs = {
    add = { text = signs.solid },
    untracked = { text = signs.solid },
    change = { text = signs.solid },
    delete = { text = signs.solid },
    topdelete = { text = signs.solid },
    changedelete = { text = signs.solid },
  },
  signs_staged = {
    add = { text = signs.dashed },
    untracked = { text = signs.dashed },
    change = { text = signs.dashed },
    delete = { text = signs.dashed },
    topdelete = { text = signs.dashed },
    changedelete = { text = signs.dashed },
  },
  on_attach = function(bufnr)
    local git = require('sQVe.utils.git')
    local gitsigns = package.loaded.gitsigns

    map('n', 'ghd', gitsigns.stage_hunk, { desc = 'Stage/unstage hunk' })
    map('n', 'ghs', gitsigns.stage_hunk, { desc = 'Stage/unstage hunk' })
    map(
      'n',
      'ghS',
      gitsigns.stage_buffer,
      { desc = 'Stage all hunks in buffer' }
    )
    map('n', 'ghr', gitsigns.reset_hunk, { desc = 'Reset hunk' })
    map(
      'n',
      'ghR',
      gitsigns.reset_buffer,
      { desc = 'Reset all hunks in buffer' }
    )
    map('n', 'ghp', gitsigns.preview_hunk_inline, { desc = 'Preview hunk' })
    map('n', ']h', function()
      gitsigns.nav_hunk('next')
    end)
    map('n', '[h', function()
      gitsigns.nav_hunk('prev')
    end)

    map('v', 'ghs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { desc = 'Stage/unstage hunk' })
    map('v', 'ghr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { desc = 'Reset hunk' })

    map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'Select hunk' })
  end,
}

return M
