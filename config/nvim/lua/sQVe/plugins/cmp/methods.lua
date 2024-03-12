-- ┏┳┓┏━╸╺┳╸╻ ╻┏━┓╺┳┓┏━┓
-- ┃┃┃┣╸  ┃ ┣━┫┃ ┃ ┃┃┗━┓
-- ╹ ╹┗━╸ ╹ ╹ ╹┗━┛╺┻┛┗━┛

local M = {}

M.abort = function(fallback)
  local cmp = require('cmp')
  local selected_entry = cmp.get_selected_entry()

  if selected_entry ~= nil then
    cmp.abort()
  else
    fallback()
  end
end

M.cycle_suggestions = function(fallback)
  local cmp = require('cmp')
  local suggestion = require('copilot.suggestion')

  if cmp.visible() then
    cmp.close()
  end

  if suggestion.is_visible() then
    suggestion.next()
  else
    fallback()
  end
end

M.expand = function(fallback)
  local luasnip = require('luasnip')
  local suggestion = require('copilot.suggestion')

  if luasnip.expandable() then
    luasnip.expand()
  elseif suggestion.is_visible() then
    suggestion.accept()
  else
    fallback()
  end
end

M.expand_snippet = function(args)
  require('luasnip').lsp_expand(args.body)
end

M.format_label = function(vim_item)
  local ELLIPSIS_CHAR = '…'
  local MAX_LABEL_WIDTH = 60
  local label = vim_item.abbr
  local label_len = string.len(label)

  if label_len > MAX_LABEL_WIDTH then
    vim_item.abbr = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
      .. ELLIPSIS_CHAR
  elseif label_len < MAX_LABEL_WIDTH then
    vim_item.abbr = label .. string.rep(' ', MAX_LABEL_WIDTH - label_len)
  end

  return vim_item
end

M.next = function(fallback)
  local cmp = require('cmp')
  local luasnip = require('luasnip')

  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.jumpable(1) then
    luasnip.jump(1)
  elseif M.has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end

local previous = function(fallback)
  local cmp = require('cmp')
  local luasnip = require('luasnip')

  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end

local signature_help = function()
  local cmp = require('cmp')

  if cmp.visible() then
    cmp.close()
  end
  vim.lsp.buf.signature_help()
end

return M
