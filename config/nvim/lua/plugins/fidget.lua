-- ┏━╸╻╺┳┓┏━╸┏━╸╺┳╸
-- ┣╸ ┃ ┃┃┃╺┓┣╸  ┃
-- ╹  ╹╺┻┛┗━┛┗━╸ ╹

return function()
  require('fidget').setup({
    text = { spinner = 'dots' },
    timer = { fidget_decay = 1000, task_decay = 500 },
    window = { blend = 50 },
  })
end
