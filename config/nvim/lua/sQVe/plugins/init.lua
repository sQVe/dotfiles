-- ╻┏┓╻╻╺┳╸
-- ┃┃┗┫┃ ┃
-- ╹╹ ╹╹ ╹

-- Add builtin plugins.
vim.cmd('packadd cfilter')

local customized_plugins = {
  'alpha',
  'bbye',
  'cmp',
  'comment',
  'fidget',
  'fm',
  'focus',
  'fugitive',
  'gitsigns',
  'gruvbox',
  'indent-blankline',
  'leap',
  'lsp',
  'lualine',
  'null-ls',
  'pasta',
  'project',
  'rust-tools',
  'sort',
  'surround',
  'telescope',
  'treesitter',
  'vsnip',
}

return require('packer').startup({
  function(use)
    -- Handle packer with packer.
    use({ 'wbthomason/packer.nvim', opt = true })

    -- Optimize startup.
    use({ 'lewis6991/impatient.nvim' })

    -- Repeat for plugins.
    use({ 'tpope/vim-repeat', event = 'BufEnter' })

    -- Editorconfig.
    use({ 'gpanders/editorconfig.nvim', event = 'BufEnter' })

    -- Git mergetool.
    use({
      'whiteinge/diffconflicts',
      cmd = {
        'DiffConflicts',
        'DiffConflictsShowHistory',
        'DiffConflictsWithHistory ',
      },
    })

    -- Complete pairs.
    use({
      'windwp/nvim-autopairs',
      event = { 'InsertEnter' },
      config = function()
        require('nvim-autopairs').setup()
      end,
    })

    -- Increment / decrement dates, times and more.
    use({
      'tpope/vim-speeddating',
      keys = {
        { 'n', '<c-a>' },
        { 'n', '<c-x>' },
      },
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

    -- Improved f, F, t, and T motions.
    use({
      'ggandor/flit.nvim',
      after = 'leap.nvim',
      config = function()
        require('flit').setup()
      end,
    })

    -- Smart selection.
    use({ 'RRethy/nvim-treesitter-textsubjects', after = 'nvim-treesitter' })

    -- Indent text object.
    use({ 'michaeljsmith/vim-indent-object', event = 'CursorMoved' })

    -- Additional text objects.
    use({ 'wellle/targets.vim', event = 'CursorMoved' })

    -- Initialize all customized plugins.
    for _, customized_plugin in ipairs(customized_plugins) do
      require('sQVe.plugins.' .. customized_plugin).init(use)
    end
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end,
    },
  },
})
