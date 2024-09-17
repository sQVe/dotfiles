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

local anyWord = [[\k\+]]
local buffer_options = {
  get_bufnrs = utils.get_visible_bufnrs,
  keyword_pattern = anyWord,
}

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
    sources = cmp.config.sources({
      { name = 'emoji' },
      { name = 'path' },
    }, {
      { name = 'nvim_lsp' },
      { name = 'lazydev' },
      { name = 'snippets' },
      {
        name = 'buffer',
        keyword_length = 4,
        option = buffer_options,
      },
    }),
  })

  cmp.setup.filetype('gitcommit', {
    sources = {
      { name = 'git' },
      { name = 'emoji' },
      { name = 'buffer', keyword_length = 2, option = buffer_options },
    },
  })

  cmp.setup.filetype('minifiles', {
    sources = {
      { name = 'buffer', keyword_length = 1, option = buffer_options },
    },
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer', keyword_length = 2, option = buffer_options },
    },
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'path' },
      { name = 'cmdline', option = { ignore_cmds = { '!' } } },
      { name = 'buffer', keyword_length = 2, option = buffer_options },
    },
  })

  require('cmp_git').setup()
end

return M
