-- ┏━┓┏━┓┏━┓ ┏┓┏━╸┏━╸╺┳╸
-- ┣━┛┣┳┛┃ ┃  ┃┣╸ ┃   ┃
-- ╹  ╹┗╸┗━┛┗━┛┗━╸┗━╸ ╹
-- Set pwd to root directory.

local M = {}

M.init = function(use)
  use({ 'ahmedkhalf/project.nvim', cmd = 'ProjectRoot', config = M.config })
end

M.config = function()
  require('project_nvim').setup({
    detection_methods = { 'pattern', 'lsp' },
    manual_mode = true,
    patterns = { '.git' },
  })
end

return M
