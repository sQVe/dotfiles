-- ┏┓ ┏━┓┏━┓┏━╸   ┏━╸┏━┓┏┳┓┏┳┓┏━┓┏┓╻╺┳┓┏━┓
-- ┣┻┓┣━┫┗━┓┣╸    ┃  ┃ ┃┃┃┃┃┃┃┣━┫┃┗┫ ┃┃┗━┓
-- ┗━┛╹ ╹┗━┛┗━╸   ┗━╸┗━┛╹ ╹╹ ╹╹ ╹╹ ╹╺┻┛┗━┛

local command = function(name, command, opts)
  local defaultOpts = { bang = true }

  vim.api.nvim_add_user_command(
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
command('Bdo', 'Bdo %bd|e#|bd#')

-- Show full path to open buffer.
command('Bpwd', 'echo expand("%:p")')

-- Set pwd to path of open buffer.
command('Cdb', 'cd %:p:h')

-- Term.
command('Term', '!term')
command('BTerm', '!term "%:p"')

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

-- Create and print Ascii Header.
command('AsciiHeader', 'call AsciiHeader(<q-args>)', { nargs = 1 })

-- Use branch name as commit message.
command(
  'CommitMsgFromBranchName',
  'call CommitMsgFromBranchName()',
  { nargs = 0 }
)

-- Open prev git commit message.
command('CommitMsgPrev', 'call CommitMsgPrev()', { nargs = 0 })

-- Search on DuckDuckGo.
command('Ddg', 'call Ddg(<q-args>)', { nargs = '?' })

-- Show documentation.
command('ShowDocumentation', 'call ShowDocumentation()', { nargs = 0 })

-- Z lookup.
command('Z', 'call Z(<q-args>)', { nargs = 1 })
