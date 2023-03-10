local path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local repo = 'https://github.com/folke/lazy.nvim.git'

if not vim.loop.fs_stat(path) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    repo,
    '--branch=stable',
    path,
  })
end

vim.opt.rtp:prepend(path)

require('lazy').setup('sQVe.plugins', {
  change_detection = {
    notify = false,
  },
  dev = {
    path = '~/code',
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
