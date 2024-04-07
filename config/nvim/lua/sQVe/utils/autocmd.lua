-- ┏━┓╻ ╻╺┳╸┏━┓┏━╸┏┳┓╺┳┓
-- ┣━┫┃ ┃ ┃ ┃ ┃┃  ┃┃┃ ┃┃
-- ╹ ╹┗━┛ ╹ ┗━┛┗━╸╹ ╹╺┻┛

return function(event, opts)
  opts = opts or {}

  if opts.group then
    vim.api.nvim_create_augroup(opts.group, { clear = true })
  end

  vim.api.nvim_create_autocmd(event, opts)
end
