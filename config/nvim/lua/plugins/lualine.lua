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
      disabled_filetypes = { 'alpha' },
      theme = gruvbox,
      component_separators = { '', '' },
      section_separators = { '', '' },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = {},
      lualine_x = { 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
  })
end
