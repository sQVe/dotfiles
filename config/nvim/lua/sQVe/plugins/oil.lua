-- ┏━┓╻╻
-- ┃ ┃┃┃
-- ┗━┛╹┗━╸
-- Edit filesystem like a buffer.

local function parse_git_filenames(proc)
  local result = proc:wait()
  if result.code ~= 0 then
    return {}
  end

  local files = {}
  for line in
    vim.gsplit(result.stdout, '\n', { plain = true, trimempty = true })
  do
    files[line:gsub('/$', '')] = true
  end

  return files
end

local function get_git_status(dir)
  local ignored = vim.system({
    'git',
    'ls-files',
    '--ignored',
    '--exclude-standard',
    '--others',
    '--directory',
  }, { cwd = dir, text = true })

  local tracked = vim.system({
    'git',
    'ls-tree',
    'HEAD',
    '--name-only',
  }, { cwd = dir, text = true })

  return {
    ignored = parse_git_filenames(ignored),
    tracked = parse_git_filenames(tracked),
  }
end

local git_cache = {}

local M = {
  'stevearc/oil.nvim',
  lazy = false,
  keys = {
    {
      'Ä',
      function()
        require('oil').open_float()
      end,
    },
  },
}

---@module 'oil'
---@type oil.SetupOpts
M.opts = {
  delete_to_trash = true,
  float = {
    max_width = 0.8,
    max_height = 0.8,
  },
  keymaps = {
    ['<Backspace>'] = { 'actions.parent', mode = 'n' },
    ['<C-c>'] = { 'actions.close', mode = 'n' },
    ['<Esc>'] = { 'actions.close', mode = 'n' },
    ['<C-t>'] = { 'actions.select', opts = { tab = true } },
    ['<C-w>p'] = 'actions.preview',
    ['<C-w><C-p>'] = 'actions.preview',
    ['<C-w>s'] = { 'actions.select', opts = { horizontal = true } },
    ['<C-w><C-s>'] = { 'actions.select', opts = { horizontal = true } },
    ['<C-w>v'] = { 'actions.select', opts = { vertical = true } },
    ['<C-w><C-v>'] = { 'actions.select', opts = { vertical = true } },
    ['<CR>'] = 'actions.select',
    ['g-'] = { 'actions.open_cwd', mode = 'n' },
    ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
    ['g?'] = { 'actions.show_help', mode = 'n' },
    ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
    ['gs'] = { 'actions.change_sort', mode = 'n' },
    ['gx'] = 'actions.open_external',
  },
  use_default_keymaps = false,
  view_options = {
    show_hidden = true,
    is_hidden_file = function(name, bufnr)
      local dir = require('oil').get_current_dir(bufnr)
      local is_dotfile = vim.startswith(name, '.') and name ~= '..'

      if not dir then
        return is_dotfile
      end

      if not git_cache[dir] then
        git_cache[dir] = get_git_status(dir)
      end

      if is_dotfile then
        return not git_cache[dir].tracked[name]
      else
        return git_cache[dir].ignored[name]
      end
    end,
  },
  watch_for_changes = true,
}

M.config = function(_, opts)
  require('oil').setup(opts)

  -- Clear git status cache on refresh.
  local refresh = require('oil.actions').refresh
  local actual_refresh = refresh.callback
  refresh.callback = function(...)
    git_cache = {}
    actual_refresh(...)
  end
end

return M
