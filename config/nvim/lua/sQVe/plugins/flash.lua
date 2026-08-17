-- ┏━╸╻  ┏━┓┏━┓╻ ╻
-- ┣╸ ┃  ┣━┫┗━┓┣━┫
-- ╹  ┗━╸╹ ╹┗━┛╹ ╹
-- Navigate code quickly with labels.

local M = {
  'folke/flash.nvim',
  event = 'VeryLazy',
  keys = {
    {
      's',
      mode = { 'n', 'x' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash search',
    },
  },
}

M.opts = {
  label = { after = false, before = true },
}

-- Neovim 0.13 stopped exporting the `search_match_lines` symbol that flash's
-- ffi hacks read, breaking every motion it hooks (f/t/F/T and `s`).
-- Upstream fix: folke/flash.nvim#492. Delete this block once it lands.
M.config = function(_, opts)
  require('flash').setup(opts)

  local hacks = require('flash.hacks')
  if pcall(hacks.save_incsearch_state) then
    return
  end

  hacks.save_incsearch_state = function() end
  hacks.restore_incsearch_state = function() end

  local Pos = require('flash.search.pos')
  local Search = require('flash.search')
  function Search:_next(flags)
    local pattern = self.state.pattern.search
    local ok, pos = pcall(vim.fn.searchpos, pattern, flags or '')
    if not ok or pos[1] == 0 then
      return
    end
    local end_pos = vim.fn.searchpos(pattern, 'cen')
    return {
      win = self.win,
      pos = Pos({ pos[1], pos[2] - 1 }),
      end_pos = Pos({ end_pos[1], end_pos[2] - 1 }),
    }
  end
end

return M
