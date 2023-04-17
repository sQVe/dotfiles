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

  dashboard.section.header.val = {
    [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
    [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
    [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
    [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
    [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
    [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
  }

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
    dashboard.button('-', '📁  File tree', '<Cmd>Neotree<CR>'),
    dashboard.button(
      'u',
      '🎒  Recently used files',
      '<Cmd>Telescope oldfiles cwd_only=true<CR>'
    ),
    dashboard.button('e', '💎  New file', '<Cmd>enew<CR>'),
    dashboard.button(
      'l',
      '💾  Load directory session',
      '<Cmd>lua require("persistence").load()<CR>'
    ),
    dashboard.button(
      'L',
      '💾  Load global session',
      '<Cmd>lua require("persistence").load({ last = true })<CR>'
    ),
    dashboard.button('z', '💤  Lazy', '<Cmd>Lazy<CR>'),
    dashboard.button('q', '🥺  Quit', '<Cmd>qa<CR>'),
  }

  dashboard.section.footer.val = { vim.fn.getcwd() }

  return {
    layout = {
      { type = 'padding', val = 12 },
      dashboard.section.header,
      { type = 'padding', val = 4 },
      dashboard.section.buttons,
      { type = 'padding', val = 4 },
      dashboard.section.footer,
    },
    opts = { margin = 5 },
  }
end

return M
