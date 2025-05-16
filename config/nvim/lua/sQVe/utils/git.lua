-- ┏━╸╻╺┳╸
-- ┃╺┓┃ ┃
-- ┗━┛╹ ╹

local M = {}

M.get_branch_name = function()
  return vim.trim(vim
    .system({
      'git',
      'rev-parse',
      '--abbrev-ref',
      'HEAD',
    })
    :wait().stdout)
end

M.get_merge_base = function()
  local default_branch = vim
    .trim(vim
      .system({
        'git',
        'symbolic-ref',
        'refs/remotes/origin/HEAD',
      }, { text = true })
      :wait().stdout)
    :gsub('refs/remotes/origin/', '')

  return vim.trim(vim
    .system({
      'git',
      'merge-base',
      'HEAD',
      default_branch,
    }, { text = true })
    :wait().stdout)
end

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
