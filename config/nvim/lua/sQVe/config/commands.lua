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

-- Delete all open buffers.
command('Bda', 'bufdo bd')

-- Delete all buffers but the open one.
command('Bdo', '%bd|e#|bd#')

-- Show full path to open buffer.
command('Bpwd', 'echo expand("%:p")')

-- Set pwd to path of open buffer.
command('Bcd', 'cd %:p:h')

-- Term.
command('Term', function(input)
  vim.cmd('silent !term ' .. input.args)
end, { nargs = '?' })
command('BTerm', function(input)
  vim.cmd('silent !term ' .. input.args .. ' ' .. vim.fn.expand('%:p:h'))
end, { nargs = '?' })

-- File manager.
command('FileManager', 'Term fm')
command('BFileManager', 'BTerm fm')

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
  require('Comment')

  local ok =
    pcall(vim.cmd, 'execute "read !toilet -f future ' .. input.args .. '"')
  if ok then
    vim.api.nvim_command('normal 0Vkkgc')
  end
end, { nargs = 1 })

-- Use branch name as commit message.
command('CommitMsgFromBranchName', function()
  local ok = pcall(vim.cmd, 'execute "read !git rev-parse --abbrev-ref HEAD"')
  if ok then
    vim.api.nvim_command('normal kdd')
    vim.api.nvim_command('substitute /\\//: /e')
    vim.api.nvim_command('substitute /-/ /e')
    vim.api.nvim_command('nohl')
  end
end, { nargs = 0 })

-- Open prev git commit message.
command('CommitMsgPrev', function()
  vim.cmd('silent execute "vsplit /tmp/PREV_COMMIT_EDITMSG"')
end, { nargs = 0 })

-- Search on DuckDuckGo.
command('Ddg', function(input)
  local root_url = 'https://duckduckgo.com/?q='
  local args = input.args or ''
  local query = (#args > 0 and args) or vim.fn.getreg('o')
  local safe_query = string.gsub(query, '%s', ' ')

  vim.cmd(
    'silent execute "!open-qutebrowser '
      .. vim.fn.shellescape(root_url .. safe_query)
      .. '"'
  )
end, { nargs = '?' })

-- Save notes.
command('SaveNotes', function()
  local script_path = vim.fn.expand('$SCRIPTS') .. '/nvim/save-notes.sh'

  local ok = pcall(vim.cmd, 'silent execute "!' .. script_path .. ' &"')
  if not ok then
    vim.api.nvim_err_writeln('Unable to save notes.')
  end
end, { nargs = 0 })
