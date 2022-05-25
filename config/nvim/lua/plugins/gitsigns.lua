--  ┏━╸╻╺┳╸┏━┓╻┏━╸┏┓╻┏━┓
--  ┃╺┓┃ ┃ ┗━┓┃┃╺┓┃┗┫┗━┓
--  ┗━┛╹ ╹ ┗━┛╹┗━┛╹ ╹┗━┛

return function()
  local gitsigns = require('gitsigns')
  local map = require('utils.keymap').map

  gitsigns.setup({
    on_attach = function(bufnr)
      map('n', '<Leader>hj', gitsigns.next_hunk, { buffer = bufnr })
      map('n', '<Leader>hk', gitsigns.prev_hunk, { buffer = bufnr })

      map({ 'n', 'v' }, '<Leader>hs', gitsigns.stage_hunk, { buffer = bufnr })
      map('n', '<Leader>hS', gitsigns.stage_buffer, { buffer = bufnr })
      map('n', '<Leader>hu', gitsigns.undo_stage_hunk, { buffer = bufnr })
      map('n', '<Leader>hU', gitsigns.reset_buffer_index, { buffer = bufnr })

      map({ 'n', 'v' }, '<Leader>hr', gitsigns.reset_hunk, { buffer = bufnr })
      map('n', '<Leader>hR', gitsigns.reset_buffer, { buffer = bufnr })

      map('n', '<Leader>hb', function()
        gitsigns.blame_line({ full = true })
      end, { buffer = bufnr })
      map('n', '<Leader>hi', gitsigns.preview_hunk, { buffer = bufnr })
      map('n', '<Leader>hq', gitsigns.setqflist, { buffer = bufnr })

      map(
        { 'o', 'x' },
        'ih',
        ':<C-U>Gitsigns select_hunk<CR>',
        { buffer = bufnr }
      )
    end,
  })
end
