-- ╻┏┓╻╻╺┳╸
-- ┃┃┗┫┃ ┃
-- ╹╹ ╹╹ ╹

-- Add builtin plugins.
vim.cmd('packadd cfilter')

local customized_plugins = {
  'alpha',
  'autopairs',
  'bbye',
  'cmp',
  'comment',
  'dap',
  'diffview',
  'dressing',
  'fidget',
  'fugitive',
  'gitsigns',
  'gruvbox',
  'illuminate',
  'indent-blankline',
  'leap',
  'lsp',
  'lualine',
  'null-ls',
  'paint',
  'project',
  'rust-tools',
  'sort',
  'surround',
  'telescope',
  'tree',
  'treesitter',
  'typescript',
  'vsnip',
}

return require('packer').startup({
  function(use)
    -- Handle packer with packer.
    use({ 'wbthomason/packer.nvim' })

    -- Optimize startup.
    use({ 'lewis6991/impatient.nvim' })

    -- Dependencies.
    use({ 'tpope/vim-repeat', event = 'BufEnter' }) -- Repeat support.
    use({ 'nvim-lua/plenary.nvim', module = 'plenary' }) -- Lua utilities.
    use({ 'nvim-tree/nvim-web-devicons', module = 'nvim-web-devicons' }) -- File icons.

    -- Editorconfig.
    use({ 'gpanders/editorconfig.nvim', event = 'BufEnter' })

    -- Improved f, F, t, and T motions.
    use({
      'ggandor/flit.nvim',
      after = 'leap.nvim',
      config = function()
        require('flit').setup()
      end,
    })

    -- Interactive registers.
    use({
      'tversteeg/registers.nvim',
      cmd = { 'Registers' },
      config = function()
        require('registers').setup()
      end,
      keys = {
        { 'i', '<c-r>' },
        { 'n', '"' },
        { 'v', '"' },
      },
    })

    -- Text objects.
    use({ 'michaeljsmith/vim-indent-object', event = 'CursorMoved' }) -- Indent text object.
    use({ 'wellle/targets.vim', event = 'CursorMoved' }) -- Additional text objects.

    -- Initialize all customized plugins.
    for _, customized_plugin in ipairs(customized_plugins) do
      require('sQVe.plugins.' .. customized_plugin).init(use)
    end
  end,
})
