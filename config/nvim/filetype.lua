-- ┏━╸╻╻  ┏━╸╺┳╸╻ ╻┏━┓┏━╸
-- ┣╸ ┃┃  ┣╸  ┃ ┗┳┛┣━┛┣╸
-- ╹  ╹┗━╸┗━╸ ╹  ╹ ╹  ┗━╸

vim.filetype.add({
  filename = {
    ['.eslintrc.json'] = 'jsonc',
  },
  extension = { jsonl = 'jsonl' },
  pattern = {
    ['.*%.github/workflows/.*%.ya?ml'] = 'yaml.github',
  },
})

vim.treesitter.language.register('json', 'jsonl')
