-- ┏━╸┏━┓┏━┓╻╻  ┏━┓╺┳╸
-- ┃  ┃ ┃┣━┛┃┃  ┃ ┃ ┃
-- ┗━╸┗━┛╹  ╹┗━╸┗━┛ ╹
-- GitHub Copilot support.

local enabled_filetypes = {
  'css',
  'dockerfile',
  'graphql',
  'html',
  'javascript',
  'javascriptreact',
  'json',
  'jsonc',
  'lua',
  'markdown',
  'scss',
  'sh',
  'typescript',
  'typescriptreact',
  'yaml',
}

local M = {
  'zbirenbaum/copilot.lua',
  build = ':Copilot auth',
  cmd = 'Copilot',
  ft = enabled_filetypes,
}

M.opts = function()
  local filetypes = {}

  for _, filetype in ipairs(enabled_filetypes) do
    filetypes[filetype] = true
  end
  filetypes['*'] = false

  return {
    filetypes = filetypes,
    panel = { enabled = false },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = { accept = '<C-l>' },
    },
  }
end

return M
