local NOTES_PATH = vim.fn.expand('$NOTES')

local M = {
  'epwalsh/obsidian.nvim',
  version = '*',
  cmd = {
    'ObsidianBacklinks',
    'ObsidianCheck',
    'ObsidianFollowLink',
    'ObsidianLink',
    'ObsidianLinkNew',
    'ObsidianNew',
    'ObsidianOpen',
    'ObsidianPasteImg',
    'ObsidianQuickSwitch',
    'ObsidianRename',
    'ObsidianSearch',
    'ObsidianTemplate',
    'ObsidianToday',
    'ObsidianTomorrow',
    'ObsidianWorkspace',
    'ObsidianYesterday',
  },
  event = {
    'BufReadPre ' .. NOTES_PATH .. '/**.md',
    'BufNewFile ' .. NOTES_PATH .. '/**.md',
  },
  keys = {
    -- stylua: ignore start
    { '<Leader>ob', mode = { 'n' }, '<Cmd>ObsidianBacklinks<CR>', desc = 'List all backlinks', },
    { '<Leader>od', mode = { 'n' }, '<Cmd>ObsidianToday<CR>', desc = 'Open daily note', },
    { '<Leader>ol', mode = { 'v' }, ':ObsidianLink', desc = 'Link note to selection', },
    { '<Leader>on', mode = { 'n' }, ':ObsidianNew ', desc = 'New note', },
    { '<Leader>on', mode = { 'v' }, ':ObsidianLinkNew ', desc = 'Link new note to selection', },
    { '<Leader>oo', mode = { 'n' }, '<Cmd>ObsidianOpen<CR>', desc = 'Open current buffer in Obsidian', },
    { '<Leader>op', mode = { 'n' }, '<Cmd>SaveNotes<CR>', desc = 'Commit and push notes', },
    { '<Leader>or', mode = { 'n' }, '<Cmd>ObsidianRename<CR>', desc = 'Rename note', },
    { '<Leader>ot', mode = { 'n' }, '<Cmd>ObsidianTemplate<CR>', desc = 'Insert template', },
    { '<Leader>oy', mode = { 'n' }, '<Cmd>ObsidianYesterday<CR>', desc = 'Open yesterdays daily note', },
    { '<Leader>oä', mode = { 'n' }, '<Cmd>ObsidianQuickSwitch<CR>', desc = 'Find note', },
    { '<Leader>oå', mode = { 'n' }, '<Cmd>ObsidianSearch<CR>', desc = 'Live grep note', },
    -- stylua: ignore end
  },
}

local function generate_frontmatter_data(note)
  local data = {
    aliases = note.aliases,
    created = os.date('%Y-%m-%d'),
    id = note.id,
    tags = note.tags,
  }

  -- Check if the note exists and has metadata. If it does, preserve existing
  -- metadata by copying values.
  if note and note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
    for key, val in pairs(note.metadata) do
      data[key] = val
    end
  end

  return data
end

local function generate_note_id(title)
  local suffix

  if title and title ~= '' then
    suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
  else
    local randomChars = {}

    for _ = 1, 4 do
      table.insert(randomChars, string.char(math.random(65, 90)))
    end
    suffix = table.concat(randomChars)
  end

  return os.date('%Y%m%d') .. '-' .. suffix
end

local function is_existing_file(filename)
  local filesize = vim.fn.getfsize(NOTES_PATH .. '/' .. filename)

  return filesize > 0
end

M.opts = {
  attachments = { img_folder = 'attachments' },
  completion = {
    -- Disable completion since we're using Marksman, a Markdown LSP.
    nvim_cmp = false,
  },
  daily_notes = {
    folder = '5-dailies',
    date_format = '%Y%m%d',
    alias_format = '%Y-%m-%d',
    template = nil,
  },
  disable_frontmatter = is_existing_file,
  follow_url_func = function(url)
    vim.fn.jobstart({ 'mimeo', url })
  end,
  mappings = {
    ['gf'] = {
      action = function()
        return require('obsidian').util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
  },
  note_frontmatter_func = generate_frontmatter_data,
  note_id_func = generate_note_id,
  notes_subdir = '0-inbox',
  templates = { subdir = 'templates' },
  workspaces = { { name = 'notes', path = NOTES_PATH } },
}

M.config = function(_, opts)
  local autocmd = require('sQVe.utils.vim').autocmd
  local augroup = require('sQVe.utils.vim').augroup

  require('obsidian').setup(opts)

  autocmd('BufEnter', {
    group = augroup('Obsidian'),
    pattern = NOTES_PATH .. '**/*.md',
    callback = function()
      vim.opt_local.shiftwidth = 2
      vim.opt_local.tabstop = 2
    end,
  })
end

return M
