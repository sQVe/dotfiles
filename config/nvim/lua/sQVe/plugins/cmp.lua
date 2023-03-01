-- ┏━╸┏┳┓┏━┓
-- ┃  ┃┃┃┣━┛
-- ┗━╸╹ ╹╹
-- Completion engine.

local M = {
  'hrsh7th/nvim-cmp',
  event = { 'CmdlineEnter', 'InsertEnter' },
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'onsails/lspkind-nvim',
    'saadparwaiz1/cmp_luasnip',
  },
}

M.config = function()
  local cmp = require('cmp')
  local lspkind = require('lspkind')
  local luasnip = require('luasnip')

  local config = cmp.config
  local mapping = cmp.mapping

  -- Pattern that matches any consecutive characters, including special ones.
  local anyWord = [[\k\+]]

  local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
      return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
      and vim.api
          .nvim_buf_get_lines(0, line - 1, line, true)[1]
          :sub(col, col)
          :match('%s')
        == nil
  end

  local mapKey = function(fn, modes)
    local defaultModes = { 'c', 'i' }

    return mapping(fn, vim.tbl_extend('force', defaultModes, modes or {}))
  end

  local signature_help = function()
    if cmp.visible() then
      cmp.close()
    end
    vim.lsp.buf.signature_help()
  end

  local next = function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.jumpable(1) then
      luasnip.jump(1)
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end

  local previous = function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end

  local parentheses = function(fallback)
    if cmp.visible() then
      cmp.complete()
      vim.api.nvim_put({ '()' }, 'c', false, true)
    else
      fallback()
    end
  end

  local expand_snippet = function(args)
    require('luasnip').lsp_expand(args.body)
  end

  cmp.setup({
    experimental = { ghost_text = { hl_group = 'GruvboxGray' } },
    formatting = {
      fields = { 'abbr', 'menu', 'kind' },
      format = lspkind.cmp_format({
        with_text = false,
        menu = {
          buffer = ' buf',
          emoji = ' emo',
          luasnip = ' snip',
          nvim_lsp = ' lsp',
          nvim_lua = ' api',
          path = ' path',
        },
      }),
    },
    mapping = mapping.preset.insert({
      ['()'] = mapKey(parentheses),
      ['<C-CR>'] = mapKey(
        mapping.complete({ reason = cmp.ContextReason.Manual })
      ),
      ['<C-Space>'] = mapKey(
        mapping.complete({ reason = cmp.ContextReason.Manual })
      ),
      ['<C-d>'] = mapKey(mapping.scroll_docs(8)),
      ['<C-e>'] = mapKey(mapping.close()),
      ['<C-k>'] = mapKey(signature_help),
      ['<C-u>'] = mapKey(mapping.scroll_docs(-8)),
      ['<CR>'] = mapKey(mapping.confirm({ select = false })),
      ['<Tab>'] = mapKey(next, { 's' }),
      ['<S-Tab>'] = mapKey(previous, { 's' }),
    }),
    snippet = { expand = expand_snippet },
    sources = config.sources({
      { name = 'nvim_lsp' },
      { name = 'path' },
      {
        name = 'luasnip',
        keyword_length = 2,
      },
      {
        name = 'buffer',
        keyword_length = 4,
        option = { keyword_pattern = anyWord },
      },
      { name = 'emoji' },
    }),
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = mapping.preset.cmdline(),
    sources = {
      {
        name = 'buffer',
        keyword_length = 2,
        option = { keyword_pattern = anyWord },
      },
    },
  })

  cmp.setup.cmdline(':', {
    mapping = mapping.preset.cmdline(),
    sources = config.sources({
      { name = 'path' },
      { name = 'cmdline', option = { ignore_cmds = { '!' } } },
      {
        name = 'buffer',
        keyword_length = 4,
        option = { keyword_pattern = anyWord },
      },
    }),
  })
end

return M
