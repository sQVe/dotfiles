-- ┏━╸╻╻  ┏━╸╺┳╸╻ ╻┏━┓┏━╸
-- ┣╸ ┃┃  ┣╸  ┃ ┗┳┛┣━┛┣╸
-- ╹  ╹┗━╸┗━╸ ╹  ╹ ╹  ┗━╸

vim.filetype.add({
  filename = {
    ['.eslintrc.json'] = 'jsonc',
  },
  extension = { jsonl = 'jsonl' },
  pattern = {},
})

vim.treesitter.language.register('json', 'jsonl')
