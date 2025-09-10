-- ┏━╸╻╺┳╸┏━╸┏━┓┏┳┓┏┳┓╻╺┳╸
-- ┃╺┓┃ ┃ ┃  ┃ ┃┃┃┃┃┃┃┃ ┃
-- ┗━┛╹ ╹ ┗━╸┗━┛╹ ╹╹ ╹╹ ╹
-- Git commit specific settings.

-- Enable spellchecking.
vim.opt_local.spell = true

-- Set recommended text width.
vim.opt_local.textwidth = 72
vim.opt_local.colorcolumn = '72'

local is_generating = false

local function add_claude_checkbox()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  for _, line in ipairs(lines) do
    if line:match('^# %[.%] Generate commit message with Claude') then
      return
    end
  end

  for i, line in ipairs(lines) do
    if line:match('^# Please enter the commit message') then
      vim.api.nvim_buf_set_lines(0, i - 1, i - 1, false, {
        '# [ ] Generate commit message with Claude',
        '#',
      })
      break
    end
  end
end

local function get_staged_diff(callback)
  vim.system({ 'git', 'diff', '--cached' }, {}, function(result)
    if result.code ~= 0 then
      vim.notify(
        'Git diff failed: ' .. (result.stderr or 'Unknown error'),
        vim.log.levels.ERROR
      )
      callback(nil)
      return
    end

    if not result.stdout or result.stdout == '' then
      vim.notify('No staged changes found', vim.log.levels.WARN)
      callback(nil)
      return
    end

    callback(result.stdout)
  end)
end

local function generate_claude_message(diff_content, callback)
  vim.system({
    'claude',
    '-p',
    '--model',
    'opus',
    'Generate a conventional commit message. Format: type(scope): description. Output only the commit message.',
  }, { stdin = diff_content }, function(result)
    if result.code ~= 0 then
      vim.notify(
        'Claude failed: ' .. (result.stderr or 'Unknown error'),
        vim.log.levels.ERROR
      )
      callback(nil)
      return
    end

    local suggestion = result.stdout
      and result.stdout:gsub('^%s*', ''):gsub('%s*$', '')
    if not suggestion or suggestion == '' then
      vim.notify('Claude returned empty response', vim.log.levels.ERROR)
      callback(nil)
      return
    end

    callback(suggestion)
  end)
end

local function check_claude_checkbox()
  if is_generating then
    vim.notify('Already generating commit message', vim.log.levels.WARN)
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local checkbox_line = nil

  for i, line in ipairs(lines) do
    if line:match('^# %[x%] Generate commit message with Claude') then
      checkbox_line = i
      break
    end
  end

  if not checkbox_line then
    return
  end

  is_generating = true
  vim.notify('Generating commit message...', vim.log.levels.INFO)

  get_staged_diff(function(diff_content)
    if not diff_content then
      is_generating = false
      return
    end

    generate_claude_message(diff_content, function(suggestion)
      vim.schedule(function()
        if suggestion then
          vim.api.nvim_buf_set_lines(
            0,
            checkbox_line - 1,
            checkbox_line,
            false,
            {
              '# [ ] Generate commit message with Claude',
            }
          )
          vim.api.nvim_buf_set_lines(0, 0, 0, false, { suggestion })
        end
        is_generating = false
      end)
    end)
  end)
end

vim.api.nvim_create_autocmd('BufWritePre', {
  buffer = 0,
  callback = check_claude_checkbox,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  buffer = 0,
  once = true,
  callback = function()
    add_claude_checkbox()
    vim.defer_fn(function()
      vim.api.nvim_win_set_cursor(0, { 1, 0 })
    end, 1)
  end,
})
