local path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local repo = 'https://github.com/folke/lazy.nvim.git'

if not vim.uv.fs_stat(path) then
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
    path = function(plugin)
      local root

      if plugin.url:lower():match('github.com/sqve/') then
        root = '~/code/personal'
      else
        root = '~/code/forks'
      end

      return root .. '/' .. plugin.name
    end,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
