-- ┏┳┓┏━╸╺┳╸╻ ╻┏━┓╺┳┓┏━┓
-- ┃┃┃┣╸  ┃ ┣━┫┃ ┃ ┃┃┗━┓
-- ╹ ╹┗━╸ ╹ ╹ ╹┗━┛╺┻┛┗━┛

local M = {}

local cursor = require('sQVe.utils.cursor')

M.abort = function(fallback)
  local cmp = require('cmp')
  local selected_entry = cmp.get_selected_entry()

  if selected_entry ~= nil then
    cmp.abort()
  else
    fallback()
  end
end

M.expand_suggestion_word = function(fallback)
  local suggestion = require('supermaven-nvim.completion_preview')

  if suggestion.has_suggestion() then
    suggestion.on_accept_suggestion_word()
  else
    fallback()
  end
end

M.expand_snippet_or_suggestion = function(fallback)
  local suggestion = require('supermaven-nvim.completion_preview')
  local find_snippet_prefix = require('snippets.utils').find_snippet_prefix

  local word_before_cursor = cursor.get_word_before()
  local snippet = find_snippet_prefix(word_before_cursor)
  local is_whitespace_only_line = string.match(
    vim.api.nvim_get_current_line(),
    '^%s*$'
  ) ~= nil

  if snippet ~= nil then
    cursor.clear_before_by_length(#word_before_cursor)
    vim.snippet.expand(snippet.body)
  elseif suggestion.has_suggestion() then
    suggestion.on_accept_suggestion()
  elseif is_whitespace_only_line then
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes('<C-t>', true, false, true),
      'n',
      true
    )
  else
    fallback()
  end
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
  -- local luasnip = require('luasnip')
  local utils = require('sQVe.plugins.cmp.utils')

  if cmp.visible() then
    cmp.select_next_item()
  elseif vim.snippet.active({ direction = 1 }) then
    vim.schedule(function()
      vim.snippet.jump(1)
    end)
  elseif utils.has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end

M.previous = function(fallback)
  local cmp = require('cmp')

  if cmp.visible() then
    cmp.select_prev_item()
  elseif vim.snippet.active({ direction = -1 }) then
    vim.schedule(function()
      vim.snippet.jump(-1)
    end)
  else
    fallback()
  end
end

M.signature_help = function()
  local cmp = require('cmp')

  if cmp.visible() then
    cmp.close()
  end
  vim.lsp.buf.signature_help()
end

return M
