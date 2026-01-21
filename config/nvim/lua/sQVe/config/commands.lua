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

-- Search on DuckDuckGo.
command('Ddg', function(input)
  local root_url = 'https://duckduckgo.com/?q='
  local args = input.args or ''
  local query = (#args > 0 and args) or vim.fn.getreg('o')
  local encoded_query = vim.uri_encode(query, 'rfc2396')

  vim
    .system({ 'qutebrowser', root_url .. encoded_query }, { detach = true })
    :wait()
end, { nargs = '?' })
