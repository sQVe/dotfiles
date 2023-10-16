-- ┏━┓╻  ┏━┓╻ ╻┏━┓
-- ┣━┫┃  ┣━┛┣━┫┣━┫
-- ╹ ╹┗━╸╹  ╹ ╹╹ ╹
-- Dashboard.

local M = {
  'goolord/alpha-nvim',
  event = 'VimEnter',
}

M.opts = function()
  local dashboard = require('alpha.themes.dashboard')
  local logo = [[
             ▄ ▄
         ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄
         █ ▄ █▄█ ▄▄▄ █ █▄█ █ █
      ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █
    ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄
    █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄
  ▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █
  █▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █
      █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█


It is essential to know a thing first
   before saying or acting upon it
  ]]

  dashboard.section.header.val = vim.split(logo, '\n')
  dashboard.section.buttons.val = {
    dashboard.button(
      'ä',
      '📝  Find files',
      '<Cmd>lua require("sQVe.utils.telescope").find_files()<CR>'
    ),
    dashboard.button(
      'å',
      '🔎  Live grep',
      '<Cmd>lua require("sQVe.utils.telescope").live_grep()<CR>'
    ),
    dashboard.button('-', '🌳  File tree', '<Cmd>Neotree<CR>'),
    dashboard.button(
      'u',
      '🎒  Recently used files',
      '<Cmd>Telescope oldfiles cwd_only=true<CR>'
    ),
    dashboard.button('e', '💎  New file', '<Cmd>enew<CR>'),
    dashboard.button(
      'g',
      '💾  Load directory session',
      '<Cmd>lua require("persistence").load()<CR>'
    ),
    dashboard.button(
      'G',
      '💾  Load global session',
      '<Cmd>lua require("persistence").load({ last = true })<CR>'
    ),
    dashboard.button('l', '💤  Lazy', '<Cmd>Lazy<CR>'),
    dashboard.button('q', '🥺  Quit', '<Cmd>qa<CR>'),
  }

  dashboard.section.footer.val = { vim.fn.getcwd() }

  return {
    layout = {
      { type = 'padding', val = 8 },
      dashboard.section.header,
      { type = 'padding', val = 2 },
      dashboard.section.buttons,
      { type = 'padding', val = 4 },
      dashboard.section.footer,
    },
    opts = { margin = 5 },
  }
end

M.config = function(_, opts)
  require('alpha').setup(opts)

  vim.api.nvim_create_autocmd('User', {
    pattern = 'LazyVimStarted',
    callback = function()
      local dashboard = require('alpha.themes.dashboard')
      local stats = require('lazy').stats()

      print(vim.inspect(stats))

      local startup_ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      local version = '         📦 v'
        .. vim.version().major
        .. '.'
        .. vim.version().minor
        .. '.'
        .. vim.version().patch
      local startup = '⚡ Rendered UI in ' .. startup_ms .. 'ms'
      local footer = version .. '\t\t' .. startup

      dashboard.section.footer.val = footer
      pcall(vim.cmd.AlphaRedraw)
    end,
  })
end

return M
