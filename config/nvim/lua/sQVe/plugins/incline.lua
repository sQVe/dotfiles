-- ╻┏┓╻┏━╸╻  ╻┏┓╻┏━╸
-- ┃┃┗┫┃  ┃  ┃┃┗┫┣╸
-- ╹╹ ╹┗━╸┗━╸╹╹ ╹┗━╸
-- Buffer floating indicator.

local M = {
  'b0o/incline.nvim',
  event = 'BufRead',
}

M.opts = {
  render = function(props)
    local bufnum = props.buf
    local buffullname = vim.api.nvim_buf_get_name(props.buf)
    local bufname = vim.fn.fnamemodify(buffullname, ':t')

    local devicon = { ' ' }
    local success, nvim_web_devicons = pcall(require, 'nvim-web-devicons')
    if success then
      local base = vim.fn.fnamemodify(buffullname, ':r')
      local ext = vim.fn.fnamemodify(buffullname, ':e')
      local ic, hl = nvim_web_devicons.get_icon(base, ext, { default = true })
      devicon = { ic, ' ', group = hl }
    end

    return { devicon, bufname }
  end,
}

return M
