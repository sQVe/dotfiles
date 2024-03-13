-- ┏━┓╻┏━╸╻┏ ┏━╸┏━┓┏━┓
-- ┣━┛┃┃  ┣┻┓┣╸ ┣┳┛┗━┓
-- ╹  ╹┗━╸╹ ╹┗━╸╹┗╸┗━┛

local M = {}

local function replace_base_path(path, base, replacement)
  local start_position, end_position = path:find(base, 1, true)

  if start_position == 1 then
    return replacement .. path:sub(end_position + 1)
  end

  local home_path = vim.fn.expand('$HOME')
  if base == home_path then
    return path
  end

  return replace_base_path(path, home_path, '~')
end

local get_cword_or_selection = function()
  local visual_mode = vim.fn.mode() == 'v'

  if visual_mode == true then
    local saved_registry = vim.fn.getreg('v')
    vim.cmd([[noautocmd sil norm "vy]])
    local selection = vim.fn.getreg('v')
    vim.fn.setreg('v', saved_registry)

    return selection
  else
    return vim.fn.expand('<cword>')
  end
end

local get_prompt_title = function(name, cwd)
  if cwd then
    return string.format(
      '%s in %s',
      name,
      replace_base_path(cwd, vim.fn.getcwd(), '.')
    )
  end

  return name
end

M.find_files = function(use_buffer_cwd)
  local builtin = require('telescope.builtin')
  local utils = require('telescope.utils')
  local opts = {
    follow = true,
    hidden = true,
    path_display = { 'truncate' },
    prompt_title = get_prompt_title(
      'Find file',
      use_buffer_cwd and utils.buffer_dir()
    ),
    show_untracked = true,
    use_git_root = false,
  }

  if use_buffer_cwd then
    opts.cwd = utils.buffer_dir()
  end

  local ok = pcall(builtin.git_files, opts)
  if not ok then
    builtin.find_files(opts)
  end
end

M.git_status = function()
  local builtin = require('telescope.builtin')

  local ok = pcall(builtin.git_status, {})
  if not ok then
    print('No git directory found')
  end
end

M.live_grep = function(use_buffer_directory)
  local builtin = require('telescope.builtin')
  local utils = require('telescope.utils')

  local opts = {
    prompt_title = get_prompt_title(
      'Live grep',
      use_buffer_directory and utils.buffer_dir()
    ),
  }

  if use_buffer_directory then
    opts.cwd = utils.buffer_dir()
  end

  builtin.live_grep(opts)
end

M.grep_string = function(use_buffer_directory)
  local builtin = require('telescope.builtin')
  local utils = require('telescope.utils')

  local opts = {
    prompt_title = get_prompt_title(
      string.format('Find text "%s"', get_cword_or_selection()),
      use_buffer_directory and utils.buffer_dir()
    ),
  }

  if use_buffer_directory then
    opts.cwd = utils.buffer_dir()
  end

  builtin.grep_string(opts)
end

return M
