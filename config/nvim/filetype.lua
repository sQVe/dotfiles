-- ┏━╸╻╻  ┏━╸╺┳╸╻ ╻┏━┓┏━╸
-- ┣╸ ┃┃  ┣╸  ┃ ┗┳┛┣━┛┣╸
-- ╹  ╹┗━╸┗━╸ ╹  ╹ ╹  ┗━╸

vim.filetype.add({
  filename = {
    ['.eslintrc.json'] = 'jsonc',
  },
  pattern = {
    ['.*%.module%.css'] = 'scss',
  },
})
