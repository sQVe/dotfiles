-- ╺┳╸╻ ╻┏━┓┏━┓╺┳╸
--  ┃ ┗┳┛┣━┛┗━┓ ┃
--  ╹  ╹ ╹  ┗━┛ ╹
-- Typst specific settings.

local function is_in_notebox(filepath)
  local notebox = vim.env.NOTEBOX
  if not notebox then
    return false
  end

  local notebox_path = vim.fn.fnamemodify(notebox, ':p')
  local resolved = vim.fn.fnamemodify(filepath, ':p')
  return vim.startswith(resolved, notebox_path)
end

local function stop_typst_watch(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local ok, job_id = pcall(vim.api.nvim_buf_get_var, bufnr, 'typst_watch_job')
  if ok and job_id and job_id > 0 then
    vim.fn.jobstop(job_id)
    vim.b[bufnr].typst_watch_job = nil
  end
end

local function start_typst_watch()
  local filepath = vim.fn.expand('%:p')
  local bufnr = vim.api.nvim_get_current_buf()

  if not is_in_notebox(filepath) then
    return
  end

  -- Don't start if already watching.
  if vim.b[bufnr].typst_watch_job then
    return
  end

  local job_id = vim.fn.jobstart({ 'typst', 'watch', filepath }, {
    detach = false,
    on_stderr = function(_, data)
      if not data then
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

-- Start watcher.
start_typst_watch()

-- Cleanup autocmds.
local group = vim.api.nvim_create_augroup('TypstWatch', { clear = false })

vim.api.nvim_create_autocmd({ 'BufDelete', 'BufWipeout', 'BufUnload' }, {
  group = group,
  buffer = 0,
  callback = function(args)
    stop_typst_watch(args.buf)
  end,
})

-- Register VimLeavePre cleanup only once globally.
if not vim.g.typst_watch_vimleave_registered then
  vim.g.typst_watch_vimleave_registered = true
  vim.api.nvim_create_autocmd('VimLeavePre', {
    group = group,
    callback = function()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local ok, job_id =
          pcall(vim.api.nvim_buf_get_var, buf, 'typst_watch_job')
        if ok and job_id and job_id > 0 then
          vim.fn.jobstop(job_id)
        end
      end
    end,
  })
end
