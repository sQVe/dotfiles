-- ╻┏┓╻╺┳╸┏━╸┏━╸┏━┓┏━┓╺┳╸╻┏━┓┏┓╻┏━┓
-- ┃┃┗┫ ┃ ┣╸ ┃╺┓┣┳┛┣━┫ ┃ ┃┃ ┃┃┗┫┗━┓
-- ╹╹ ╹ ╹ ┗━╸┗━┛╹┗╸╹ ╹ ╹ ╹┗━┛╹ ╹┗━┛

return {
  alpha = true,
  blink_cmp = true,
  diffview = true,
  fidget = true,
  flash = true,
  gitsigns = true,
  illuminate = { enabled = true },
  markdown = true,
  mini = { enabled = true, indentscope_color = '' },
  native_lsp = {
    enabled = true,
    inlay_hints = { background = true },
    underlines = {
      errors = { 'undercurl' },
      hints = { 'underline' },
      warnings = { 'undercurl' },
      information = { 'underline' },
    },
    virtual_text = {
      errors = { 'italic' },
      hints = { 'italic' },
      warnings = { 'italic' },
      information = { 'italic' },
    },
  },
  render_markdown = true,
  semantic_tokens = true,
  snacks = true,
  treesitter = true,
  which_key = true,
}
