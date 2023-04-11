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
      '📝  Find file',
      '<Cmd>lua require("sQVe.utils.telescope").find_files(true)<CR>'
    ),
    dashboard.button(
      'å',
      '🔎  Grep',
      '<Cmd>lua require("telescope.builtin").live_grep({ prompt_title = "Grep" })<CR>'
    ),
    dashboard.button('-', '📁  File tree', '<Cmd>Neotree<CR>'),
    dashboard.button(
      'u',
      '🎒  Recently used files',
      '<Cmd>Telescope oldfiles cwd_only=true<CR>'
    ),
    dashboard.button('e', '💎  New file', '<Cmd>enew<CR>'),
    dashboard.button('l', '💤  Lazy', '<Cmd>Lazy<CR>'),
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
