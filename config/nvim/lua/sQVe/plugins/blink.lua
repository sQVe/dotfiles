-- ┏┓ ╻  ╻┏┓╻╻┏    ┏━╸┏┳┓┏━┓
-- ┣┻┓┃  ┃┃┗┫┣┻┓   ┃  ┃┃┃┣━┛
-- ┗━┛┗━╸╹╹ ╹╹ ╹   ┗━╸╹ ╹╹
-- Performant completion.

local M = {
  'saghen/blink.cmp',
  build = 'cargo build --release',
  event = 'InsertEnter',
}

M.opts = {
  keymap = {
    ['<C-Space>'] = { 'hide_documentation', 'show', 'show_documentation' },
    ['<C-CR>'] = { 'hide_documentation', 'show', 'show_documentation' },
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<Tab>'] = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-j>'] = { 'snippet_forward', 'fallback' },
    ['<C-k>'] = { 'snippet_backward', 'fallback' },
  },
  sources = {
    completion = {
      enabled_providers = { 'lazydev', 'lsp', 'buffer', 'path', 'snippets' },
    },
    list = { selection = 'auto_insert' },
    menu = {
      columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon' } },
      documentation = { auto_show = true },
    },
    providers = {
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
      },
      lsp = {
        name = 'LSP',
        module = 'blink.cmp.sources.lsp',
        fallback_for = { 'lazydev' },
      },
      buffer = {
        name = 'Buffer',
        module = 'blink.cmp.sources.buffer',
        fallback_for = { 'lsp' },
      },
      path = {
        name = 'Path',
        module = 'blink.cmp.sources.path',
        score_offset = 3,
        opts = {
          show_hidden_files_by_default = true,
        },
      },
      snippets = {
        name = 'Snippets',
        module = 'blink.cmp.sources.snippets',
        keyword_length = 1,
        score_offset = -3,
        opts = {
          extended_filetypes = {
            javascriptreact = { 'javascript' },
            typescript = { 'javascript' },
            typescriptreact = {
              'javascript',
              'javascriptreact',
              'typescript',
            },
          },
          friendly_snippets = false,
        },
      },
    },
  },
  trigger = {
    signature_help = { enabled = true },
  },
}

return M
