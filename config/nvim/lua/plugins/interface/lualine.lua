--  ╻  ╻ ╻┏━┓╻  ╻┏┓╻┏━╸
--  ┃  ┃ ┃┣━┫┃  ┃┃┗┫┣╸
--  ┗━╸┗━┛╹ ╹┗━╸╹╹ ╹┗━╸
return function()
  local gruvbox = require('lualine.themes.gruvbox')
  local modes = {
    'command',
    'inactive',
    'insert',
    'normal',
    'replace',
    'visual',
  }

  for _, mode in pairs(modes) do
    gruvbox[mode].c.gui = 'italic'
  end

  require('lualine').setup({
    options = {
      component_separators = { '', '' },
      section_separators = { '', '' },
      disabled_filetypes = { 'alpha' },
      theme = gruvbox,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'filename' },
      lualine_c = { 'branch' },
      lualine_x = { 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'filename' },
    },
  })
end
