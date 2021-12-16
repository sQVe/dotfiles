--  ┏━╸╻╺┳╸┏━┓╻┏━╸┏┓╻┏━┓
--  ┃╺┓┃ ┃ ┗━┓┃┃╺┓┃┗┫┗━┓
--  ┗━┛╹ ╹ ┗━┛╹┗━┛╹ ╹┗━┛

return function()
  require('gitsigns').setup({
    signcolumn = false,
    numhl = true,
    keymaps = {
      noremap = true,

      ['n <Leader>hj'] = '<Cmd>Gitsigns next_hunk<CR>',
      ['n <Leader>hk'] = '<Cmd>Gitsigns prev_hunk<CR>',

      ['n <Leader>hs'] = '<Cmd>Gitsigns stage_hunk<CR>',
      ['v <Leader>hs'] = ':Gitsigns stage_hunk<CR>',
      ['n <Leader>hS'] = '<Cmd>Gitsigns stage_buffer<CR>',
      ['n <Leader>hu'] = '<Cmd>Gitsigns undo_stage_hunk<CR>',

      ['n <Leader>hr'] = '<Cmd>Gitsigns reset_hunk<CR>',
      ['v <Leader>hr'] = ':Gitsigns reset_hunk<CR>',
      ['n <Leader>hR'] = '<Cmd>Gitsigns reset_buffer<CR>',
      ['n <Leader>hU'] = '<Cmd>Gitsigns reset_buffer_index<CR>',

      ['n <Leader>hb'] = '<Cmd>lua require"gitsigns".blame_line{full=true}<CR>',
      ['n <Leader>hi'] = '<Cmd>Gitsigns preview_hunk<CR>',
      ['n <Leader>hq'] = '<Cmd>Gitsigns setqflist<CR>',

      ['o ih'] = ':<C-U>Gitsigns select_hunk<CR>',
      ['x ih'] = ':<C-U>Gitsigns select_hunk<CR>',
    },
  })
end
