-- ┏┳┓╻┏┓╻╻   ┏━┓┏━┓╻┏━┓┏━┓
-- ┃┃┃┃┃┗┫┃   ┣━┛┣━┫┃┣┳┛┗━┓
-- ╹ ╹╹╹ ╹╹   ╹  ╹ ╹╹╹┗╸┗━┛
-- Automatically manage character pairs.

local M = {
  'echasnovski/mini.pairs',
  event = 'VeryLazy',
}

M.opts = {
  modes = { insert = true, command = true, terminal = false },
}

M.config = function(_, opts)
  local pairs = require('mini.pairs')
  local open = pairs.open

  pairs.setup(opts)

  ---@diagnostic disable-next-line: duplicate-set-field
  pairs.open = function(pair, neigh_pattern)
    if vim.fn.getcmdline() ~= '' then
      return open(pair, neigh_pattern)
    end

    local o, c = pair:sub(1, 1), pair:sub(2, 2)
    local line = vim.api.nvim_get_current_line()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local next = line:sub(cursor[2] + 1, cursor[2] + 1)
    local before = line:sub(1, cursor[2])

    -- Handle markdown code blocks more gracefully.
    if
      vim.bo.filetype == 'markdown'
      and o == '`'
      and before:match('^%s*``')
    then
      return '`\n```'
        .. vim.api.nvim_replace_termcodes('<up>', true, true, true)
    end

    -- Skip pairing when next character matches pattern.
    if next ~= '' and next:match([=[[%w%%%'%[%"%.%`%$]]=]) then
      return o
    end

    -- Skip pairing when next character is closing pair and there are more
    -- closing pairs than opening pairs.
    if next == c and c ~= o then
      local _, count_open = line:gsub(vim.pesc(pair:sub(1, 1)), '')
      local _, count_close = line:gsub(vim.pesc(pair:sub(2, 2)), '')
      if count_close > count_open then
        return o
      end
    end

    -- Skip pairing for string treesitter nodes.
    local ok, captures = pcall(
      vim.treesitter.get_captures_at_pos,
      0,
      cursor[1] - 1,
      math.max(cursor[2] - 1, 0)
    )
    for _, capture in ipairs(ok and captures or {}) do
      if vim.tbl_contains({ 'string' }, capture.capture) then
        return o
      end
    end

    return open(pair, neigh_pattern)
  end
end

return M
