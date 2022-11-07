-- ┏━┓╻  ┏━┓╻ ╻┏━┓
-- ┣━┫┃  ┣━┛┣━┫┣━┫
-- ╹ ╹┗━╸╹  ╹ ╹╹ ╹
-- Dashboard.

local M = {}

M.init = function(use)
  use({ 'goolord/alpha-nvim', config = M.config, event = 'VimEnter' })
end

M.config = function()
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
      '📝  Find File',
      '<Cmd>lua require("sQVe.plugins.telescope").find_files()<CR>'
    ),
    dashboard.button('å', '🔎  Live Word', '<Cmd>Telescope live_grep<CR>'),
    dashboard.button('-', '📁  File Manager', '<Cmd>NvimTreeToggle<CR>'),
    dashboard.button(
      '<Backspace>',
      '🔴  Git Status',
      '<Cmd>lua require("sQVe.plugins.telescope").git_status()<CR>'
    ),
    dashboard.button(
      'u',
      '🎒  Recently Used Files',
      '<Cmd>Telescope oldfiles cwd_only=true<CR>'
    ),
    dashboard.button('e', '💎  New File', '<Cmd>enew<CR>'),
    dashboard.button('C', '🛠️  Packer Compile', '<Cmd>PackerCompile<CR>'),
    dashboard.button('S', '🔃  Packer Sync', '<Cmd>PackerSync<CR>'),
    dashboard.button('q', '🥺  Quit', '<Cmd>qa<CR>'),
  }

  dashboard.section.footer.val = { vim.fn.getcwd() }

  require('alpha').setup({
    layout = {
      { type = 'padding', val = 8 },
      dashboard.section.header,
      { type = 'padding', val = 4 },
      dashboard.section.buttons,
      { type = 'padding', val = 4 },
      dashboard.section.footer,
    },
    opts = { margin = 5 },
  })
end

return M
