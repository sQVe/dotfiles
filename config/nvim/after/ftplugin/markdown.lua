-- ┏┳┓┏━┓┏━┓╻┏ ╺┳┓┏━┓╻ ╻┏┓╻
-- ┃┃┃┣━┫┣┳┛┣┻┓ ┃┃┃ ┃┃╻┃┃┗┫
-- ╹ ╹╹ ╹╹┗╸╹ ╹╺┻┛┗━┛┗┻┛╹ ╹
-- Markdown specific settings.

-- Disable conceal.
vim.opt_local.conceallevel = 0

-- Enable spellchecking.
vim.opt_local.spell = true

-- Do not expand tabs to spaces.
vim.opt_local.expandtab = false
vim.opt_local.tabstop = 3

-- Improve text formatting.
vim.opt_local.formatoptions:append('t')
vim.opt_local.textwidth = 100

-- Move cursor to end for Claude Code prompts.
local bufname = vim.api.nvim_buf_get_name(0)
if bufname:match('^/tmp/claude%-prompt%-.*%.md$') then
  vim.cmd('normal! G$')
end

-- Notebox live PDF watcher.
local notebox_types = {
  weekly = 'week',
  reference = 'file',
  projects = 'year',
}

local function get_notebox_root()
  local notebox = vim.env.NOTEBOX
  if notebox == nil then
    return nil
  end
  return vim.fn.fnamemodify(notebox, ':p')
end

local function parse_notebox_path(filepath, notebox_root)
  if not vim.startswith(filepath, notebox_root) then
    return nil
  end

  local relative = filepath:sub(#notebox_root + 1)
  local dir, name = relative:match('^([^/]+)/(.+)%.md$')
  if dir == nil or name == nil then
    return nil
  end

  local input_key = notebox_types[dir]
  if input_key == nil then
    return nil
  end

  return { type = dir, input_key = input_key, name = name }
end

local function stop_typst_watch(bufnr)
  local ok, job_id = pcall(vim.api.nvim_buf_get_var, bufnr, 'typst_watch_job')
  if ok and job_id and job_id > 0 then
    vim.fn.jobstop(job_id)
    vim.b[bufnr].typst_watch_job = nil
  end
end

local function start_typst_watch(bufnr, info, notebox_root)
  if vim.b[bufnr].typst_watch_job then
    return
  end

  local render_file = 'render/' .. info.type .. '.typ'
  local output_file = 'pdf/' .. info.type .. '/' .. info.name .. '.pdf'

  vim.fn.mkdir(notebox_root .. 'pdf/' .. info.type, 'p')

  local job_id = vim.fn.jobstart({
    'typst',
    'watch',
    '--root',
    '.',
    '--input',
    info.input_key .. '=' .. info.name,
    render_file,
    output_file,
  }, {
    cwd = notebox_root,
    detach = false,
    on_stderr = function(_, data)
      if data == nil then
        return
      end
      for _, line in ipairs(data) do
        if line:match('^error:') then
          vim.schedule(function()
            vim.notify('typst: ' .. line, vim.log.levels.ERROR)
          end)
          break
        end
      end
    end,
    on_exit = function()
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.b[bufnr].typst_watch_job = nil
      end
    end,
  })

  if job_id > 0 then
    vim.b[bufnr].typst_watch_job = job_id
  end
end

local notebox_root = get_notebox_root()
if notebox_root ~= nil then
  local filepath = vim.fn.expand('%:p')
  local info = parse_notebox_path(filepath, notebox_root)
  if info ~= nil then
    local current_bufnr = vim.api.nvim_get_current_buf()
    start_typst_watch(current_bufnr, info, notebox_root)

    if info.type == 'weekly' then
      local today_heading = os.date('## %A %Y-%m-%d')
      vim.schedule(function()
        local line = vim.fn.search('^' .. today_heading .. '$', 'cw')
        if line > 0 then
          vim.cmd('normal! zt')
        end
      end)
    end

    local group = vim.api.nvim_create_augroup('NoteboxWatch', { clear = false })

    vim.api.nvim_create_autocmd({ 'BufDelete', 'BufWipeout', 'BufUnload' }, {
      group = group,
      buffer = 0,
      callback = function(args)
        stop_typst_watch(args.buf)
      end,
    })

    if not vim.g.notebox_watch_vimleave_registered then
      vim.g.notebox_watch_vimleave_registered = true
      vim.api.nvim_create_autocmd('VimLeavePre', {
        group = group,
        callback = function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            stop_typst_watch(buf)
          end
        end,
      })
    end
  end
end
