-- ┏━╸╻ ╻   ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓┏━┓
-- ┣╸ ┏╋┛   ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃┗━┓
-- ┗━╸╹ ╹   ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛┗━┛

local command = function(name, command, opts)
  local defaultOpts = { bang = true }

  vim.api.nvim_create_user_command(
    name,
    command,
    vim.tbl_extend('force', defaultOpts, opts or {})
  )
end

-- Clear marks.
command('ClearMarks', ':delm! | delm A-Z0-9 | wshada!')

-- Clear registers.
command(
  'ClearRegisters',
  'for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor'
)

-- Write, close and quit typos.
command('Q', 'quit')
command('Qa', 'qa')
command('W', 'write')
command('Wa', 'wa')
command('Wq', 'wq')
command('Wqa', 'wqa')

-- ┏━╸╻ ╻┏┓╻┏━╸╺┳╸╻┏━┓┏┓╻   ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓┏━┓
-- ┣╸ ┃ ┃┃┗┫┃   ┃ ┃┃ ┃┃┗┫   ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃┗━┓
-- ╹  ┗━┛╹ ╹┗━╸ ╹ ╹┗━┛╹ ╹   ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛┗━┛

-- Print as a commented Ascii Header.
command('AsciiHeader', function(input)
  -- Ensure that we have the comment plugin loaded.
  require('mini.comment')

  local ok = pcall(vim.fn.execute, 'read !toilet -f future ' .. input.args)
  if ok then
    vim.api.nvim_command('normal 0Vkkgc')
  end
end, { nargs = 1 })

-- Search on DuckDuckGo.
command('Ddg', function(input)
  local root_url = 'https://duckduckgo.com/?q='
  local args = input.args or ''
  local query = (#args > 0 and args) or vim.fn.getreg('o')
  local safe_query = string.gsub(query, '%s', ' ')

  vim
    .system({ 'open-qutebrowser', root_url .. safe_query }, { detach = true })
    :wait()
end, { nargs = '?' })
