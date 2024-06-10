-- ┏━╸┏┳┓┏━┓
-- ┃  ┃┃┃┣━┛
-- ┗━╸╹ ╹╹
-- Completion engine.

local methods = require('sQVe.plugins.cmp.methods')
local utils = require('sQVe.plugins.cmp.utils')

local M = {
  'hrsh7th/nvim-cmp',
  event = { 'CmdlineEnter', 'InsertEnter' },
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'petertriho/cmp-git',
  },
}

local get_buffer_source = function(keyword_length)
  -- Pattern that matches any consecutive characters, including special ones.
  local anyWord = [[\k\+]]

  return {
    name = 'buffer',
    keyword_length = keyword_length,
    option = {
      get_bufnrs = utils.get_visible_bufnrs,
      keyword_pattern = anyWord,
    },
  }
end

M.config = function()
  local cmp = require('cmp')
  local lspkind = require('lspkind')

  local mapping = function(fn, modes)
    local defaultModes = { 'c', 'i' }

    return cmp.mapping(fn, vim.tbl_extend('force', defaultModes, modes or {}))
  end

  cmp.setup({
    formatting = {
      expandable_indicator = true,
      fields = { 'abbr', 'menu', 'kind' },
      format = function(entry, vim_item)
        vim_item = lspkind.cmp_format({
          menu = {
            buffer = ' buf',
            emoji = ' emo',
            git = ' git',
            snippets = ' sni',
            nvim_lsp = ' lsp',
            nvim_lua = ' api',
            path = ' path',
          },
          mode = 'symbol',
          symbol_map = utils.get_symbol_map(),
        })(entry, vim_item)

        return methods.format_label(vim_item)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-CR>'] = mapping(
        cmp.mapping.complete({ reason = cmp.ContextReason.Manual })
      ),
      ['<C-Space>'] = mapping(
        cmp.mapping.complete({ reason = cmp.ContextReason.Manual })
      ),
      ['<C-c>'] = mapping(methods.abort),
      ['<C-d>'] = mapping(cmp.mapping.scroll_docs(8)),
      ['<C-j>'] = mapping(methods.expand_suggestion_word),
      ['<C-k>'] = mapping(methods.signature_help),
      ['<C-l>'] = mapping(methods.expand_snippet_or_suggestion),
      ['<C-u>'] = mapping(cmp.mapping.scroll_docs(-8)),
      ['<CR>'] = mapping(cmp.mapping.confirm({ select = false })),
      ['<Tab>'] = mapping(methods.next, { 's' }),
      ['<S-Tab>'] = mapping(methods.previous, { 's' }),
    }),
    performance = {
      async_budget = 1,
      confirm_resolve_timeout = 80,
      debounce = 60,
      fetching_timeout = 250,
      max_view_entries = 100,
      throttle = 30,
    },
    sources = cmp.config.sources(
      { { name = 'path' }, { name = 'emoji' } },
      { { name = 'snippets' } },
      { { name = 'nvim_lsp' }, { name = 'lazydev' } },
      { get_buffer_source(4) }
    ),
  })

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { { name = 'git' } },
      { { name = 'emoji' } },
      { get_buffer_source(2) },
    }),
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { get_buffer_source(2) },
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
      { { name = 'path' } },
      { { name = 'cmdline', option = { ignore_cmds = { '!' } } } },
      { get_buffer_source(4) }
    ),
  })

  require('cmp_git').setup()
end

return M
