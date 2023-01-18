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
      '📝  Find File',
      '<Cmd>lua require("sQVe.plugins.telescope").find_files(true)<CR>'
    ),
    dashboard.button(
      'Å',
      '🔎  Grep In All Files',
      '<Cmd>lua require("telescope.builtin").live_grep({ prompt_title = "Grep In All Files" })<CR>'
    ),
    dashboard.button('-', '📁  File Tree', '<Cmd>Neotree<CR>'),
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
    dashboard.button('l', '💤  Lazy', '<Cmd>Lazy<CR>'),
    dashboard.button('q', '🥺  Quit', '<Cmd>qa<CR>'),
  }

  dashboard.section.footer.val = { vim.fn.getcwd() }

  return {
    layout = {
      { type = 'padding', val = 8 },
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
