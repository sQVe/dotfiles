-- ┏━╸╻╺┳╸┏━╸┏━┓┏┳┓┏┳┓╻╺┳╸
-- ┃╺┓┃ ┃ ┃  ┃ ┃┃┃┃┃┃┃┃ ┃
-- ┗━┛╹ ╹ ┗━╸┗━┛╹ ╹╹ ╹╹ ╹
-- Git commit specific settings.

-- Enable spellchecking.
vim.opt_local.spell = true

-- Set recommended text width.
vim.opt_local.textwidth = 72
vim.opt_local.colorcolumn = '72'

vim.api.nvim_create_autocmd('BufWinEnter', {
  buffer = 0,
  once = true,
  callback = function()
    vim.defer_fn(function()
      vim.api.nvim_win_set_cursor(0, { 1, 0 })
    end, 1)
  end,
})
