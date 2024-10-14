-- ┏┓ ╻  ╻┏┓╻╻┏    ┏━╸┏┳┓┏━┓
-- ┣┻┓┃  ┃┃┗┫┣┻┓   ┃  ┃┃┃┣━┛
-- ┗━┛┗━╸╹╹ ╹╹ ╹   ┗━╸╹ ╹╹
-- Performant completion.

local M = {
  'saghen/blink.cmp',
  build = 'cargo build --release',
}

M.opts = {
  highlight = { use_nvim_cmp_as_default = true },
  keymap = {
    accept = '<CR>',
    hide = '<C-e>',
    scroll_documentation_down = '<C-d>',
    scroll_documentation_up = '<C-u>',
    select_next = { '<Down>', '<Tab>' },
    select_prev = { '<Up>', '<S-Tab>' },
    show = { '<C-Space>', '<C-CR>' },
  },
  sources = {
    providers = {
      { 'blink.cmp.sources.lsp', name = 'LSP' },
      {
        'blink.cmp.sources.buffer',
        name = 'Buffer',
        fallback_for = { 'LSP' },
      },
      { 'blink.cmp.sources.path', name = 'Path', score_offset = 3 },
      {
        'blink.cmp.sources.snippets',
        name = 'Snippets',
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
    completion = {
      show_on_insert_on_trigger_character = false,
    },
    signature_help = { enabled = true },
  },
  windows = {
    autocomplete = { selection = 'auto_insert' },
  },
}

return M
