-- ┏━╸╻╺┳╸
-- ┃╺┓┃ ┃
-- ┗━┛╹ ╹

local M = {}

M.get_root = function()
  return vim.trim(vim
    .system({
      'git',
      'rev-parse',
      '--show-toplevel',
    }, { text = true })
    :wait().stdout)
end

M.has_changed_files = function()
  return vim
    .system({
      'git',
      'status',
      '--porcelain',
    })
    :wait().stdout ~= ''
end

M.is_inside_repo = function()
  return vim
    .system({
      'git',
      'rev-parse',
      '--is-inside-work-tree',
    })
    :wait().code == 0
end

return M
